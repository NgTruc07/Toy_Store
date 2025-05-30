import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './HighlightList.css'; // ✅ Dùng style riêng cho khung nổi bật

const HighlightList = () => {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:5228/api/product/highlight')
      .then((res) => setProducts(res.data))
      .catch((err) => console.error('Lỗi sản phẩm nổi bật:', err));
  }, []);

  return (
    <div className="highlight-list">
      <h3>Sản phẩm phổ biến</h3>
      {products.slice(0, 3).map((p) => (
        <div className="highlight-item" key={p.productId}>
          <img
            src={p.urlImage1 || 'https://via.placeholder.com/60'}
            alt={p.name}
          />
          <div className="info">
            <div>{p.name}</div>
            <strong>{p.price1?.toLocaleString('vi-VN')} ₫</strong>
          </div>
        </div>
      ))}
    </div>
  );
};

export default HighlightList;
