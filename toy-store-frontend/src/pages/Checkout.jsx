import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './Checkout.css';

const Checkout = () => {
  const [items, setItems] = useState([]);
  const [total, setTotal] = useState(0);
  const [discount, setDiscount] = useState(0);
  const [name, setName] = useState('');
  const [phone, setPhone] = useState('');
  const [address, setAddress] = useState('');
  const [note, setNote] = useState('');
  const [addressId, setAddressId] = useState('');
  const navigate = useNavigate();
  const user = JSON.parse(localStorage.getItem('user'));
  const isBuyNow = new URLSearchParams(window.location.search).get('mode') === 'buynow';

  useEffect(() => {
    if (!user?.userId) return;

    axios.get(`http://localhost:5228/api/Address/default/${user.userId}`)
      .then(res => {
        console.log("🎯 RES DATA:", res.data);
        setName(res.data.Name);
        setPhone(res.data.Phone);
        setAddress(res.data.Address);
        setAddressId(res.data.AddressId); 
      });

    if (isBuyNow) {
      const product = JSON.parse(sessionStorage.getItem('buynowProduct'));
      if (product) {
        setItems([product]);
      }
    } else {
      axios.get(`http://localhost:5228/api/Cart?userId=${user.userId}`)
        .then(res => {
          setItems(res.data);
        });
    }
  }, []);

  useEffect(() => {
    let totalPrice = 0;
    let totalDiscount = 0;

    items.forEach(item => {
      const price1 = item.price1 || item.price;
      const price2 = item.price2 || item.price;
      totalPrice += price2 * item.quantity;
      totalDiscount += (price1 - price2) * item.quantity;
    });

    setTotal(totalPrice);
    setDiscount(totalDiscount);
  }, [items]);

  const shippingFee = total < 500000 ? 30000 : 0;
  const finalAmount = total + shippingFee;

  const handleConfirm = async () => {
    if (!user?.userId) {
      alert('Vui lòng đăng nhập để thanh toán.');
      return;
    }

    if (!addressId) {
      alert('Không tìm thấy địa chỉ giao hàng.');
      return;
    }

    const payload = {
      buyer: user.userId,
      seller: 1,
      description: note,
      addressId: addressId,
      items: items.map(item => ({
        productId: item.productId,
        quantity: item.quantity,
        cost: item.cost || 0,
        price: item.price2 || item.price,
        price1: item.price1 || item.price,
        price2: item.price2 || 0
      }))
    };

    console.log("Payload gửi lên:", payload);

    try {
      const res = await axios.post('http://localhost:5228/api/Orders/create', payload);
      alert('Đặt hàng thành công!');

      if (!isBuyNow) {
        await axios.delete(`http://localhost:5228/api/Cart/clear?userId=${user.userId}`);
      }

      navigate('/');
    } catch (err) {
      console.error('Lỗi khi gửi đơn hàng:', err.response?.data || err.message);
      alert('Đặt hàng thất bại!');
    }
  };

  return (
    <div className="checkout-page">
      <h2>Thanh toán</h2>
      <div className="checkout-container">
        <div className="left">
          <input placeholder="Họ và tên" value={name} onChange={(e) => setName(e.target.value)} />
          <input placeholder="Số điện thoại" value={phone} onChange={(e) => setPhone(e.target.value)} />
          <input placeholder="Địa chỉ giao hàng" value={address} onChange={(e) => setAddress(e.target.value)} />
          <textarea placeholder="Ghi chú (tuỳ chọn)" value={note} onChange={(e) => setNote(e.target.value)} rows={4} />
        </div>

        <div className="right">
          {items.map((item) => (
            <div className="checkout-item" key={item.productId}>
              <img src={item.urlImage} alt={item.productName} />
              <div>
                <div>{item.productName}</div>
                <div>
                  {item.quantity} x{' '}
                  {item.price2 && item.price2 < item.price1 ? (
                    <>
                      <span className="price-discounted">{item.price2.toLocaleString()}₫</span>
                      <span className="price-original" style={{ textDecoration: 'line-through', marginLeft: 5 }}>
                        {item.price1.toLocaleString()}₫
                      </span>
                    </>
                  ) : (
                    <span>{item.price.toLocaleString()}₫</span>
                  )}
                </div>
              </div>
            </div>
          ))}

          <div className="summary">
            <p><span>Tạm tính</span><span>{total.toLocaleString()} ₫</span></p>
            <p><span>Tiết kiệm</span><span>{discount.toLocaleString()} ₫</span></p>
            <p><span>Phí vận chuyển</span><span>{shippingFee.toLocaleString()} ₫</span></p>
            <h3><span>Tổng cộng</span><span>{finalAmount.toLocaleString()} ₫</span></h3>
          </div>

          <button className="confirm-btn" onClick={handleConfirm}>Xác nhận thanh toán</button>
          <button className="continue-btn" onClick={() => navigate('/')}>Tiếp tục mua sắm</button>
        </div>
      </div>
    </div>
  );
};

export default Checkout;
