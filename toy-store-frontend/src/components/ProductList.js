// import React, { useEffect, useState } from 'react';
// import axios from 'axios';
// import { Link, useNavigate } from 'react-router-dom';
// import { toast } from 'react-toastify';
// import './ProductList.css';

// const ProductList = ({ onAddToCartPopup }) => {
//   const [products, setProducts] = useState([]);
//   const navigate = useNavigate(); // 👈 Thêm navigate để chuyển hướng nếu chưa đăng nhập

//   useEffect(() => {
//     axios.get('http://localhost:5228/api/product')
//       .then((response) => {
//         setProducts(response.data.data);
//       })
//       .catch((error) => {
//         console.error('Lỗi khi gọi API:', error);
//         toast.error('Không thể tải danh sách sản phẩm.');
//       });
//   }, []);

//   const handleAddToCart = (product) => {
//     const user = JSON.parse(localStorage.getItem('user'));

//     if (!user) {
//       toast.warn("Vui lòng đăng nhập để thêm vào giỏ hàng.");
//       localStorage.setItem('redirectAfterLogin', window.location.pathname);
//       navigate('/login');
//       return;
//     }

//     const cartItem = {
//       userId: user.userId,
//       productId: product.productId,
//       productName: product.name,
//       quantity: 1,
//       price: product.price1,
//       urlImage: product.urlImage1
//     };

//     axios.post('http://localhost:5228/api/cart/add', cartItem)
//       .then((res) => {
//         toast.success(res.data.message || 'Đã thêm vào giỏ hàng');
//         if (onAddToCartPopup) onAddToCartPopup();
//       })
//       .catch((err) => {
//         console.error('Lỗi thêm giỏ hàng:', err);
//         toast.error('Thêm vào giỏ hàng thất bại!');
//       });
//   };

//  return (
//   <div className="product-section">
//     <h2 className="product-title-1">Danh mục sản phẩm</h2>
//     <div className="product-list">
//       {products.length === 0 ? (
//         <p>Đang tải sản phẩm...</p>
//       ) : (
//         products.map((p) => (
//           <div className="product-card" key={p.productId}>
//             <Link to={`/product/${p.productId}`} style={{ textDecoration: 'none', color: 'inherit' }}>
//               <img src={p.urlImage1 || 'https://via.placeholder.com/150'} alt={p.name} />
//               <h3>{p.name}</h3>
//               <p>{p.price1?.toLocaleString('vi-VN')} ₫</p>
//             </Link>
//             <button onClick={() => handleAddToCart(p)}>Thêm vào giỏ hàng</button>
//           </div>
//         ))
//       )}
//     </div>
//   </div>
// );
// };

// export default ProductList;
