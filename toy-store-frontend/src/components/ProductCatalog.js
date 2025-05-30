import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './ProductCatalog.css';
import ProductFilter from './ProductFilter';
import HighlightList from './HighlightList';
import { useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';

const ProductCatalog = ({ onAddToCartPopup, keyword }) => {
  const [products, setProducts] = useState([]);
  const [sort, setSort] = useState('');
  const [category, setCategory] = useState('');
  const [price, setPrice] = useState({ min: 0, max: Infinity });
  const [viewMode, setViewMode] = useState('grid3');
  const [currentPage, setCurrentPage] = useState(1);
  const navigate = useNavigate();

  const getItemsPerPage = () => (viewMode === 'grid2' ? 6 : 9);

  const resetAllFilters = () => {
    setCategory('');
    setPrice({ min: 0, max: Infinity });
    setSort('');
  };

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        let productList = [];

        if (keyword) {
          const res = await axios.get('http://localhost:5228/api/product/search', {
            params: { keyword }
          });
          productList = res.data;
        } else {
          const params = {
            categoryName: category || undefined,
            minPrice: isFinite(price.min) ? price.min : undefined,
            maxPrice: isFinite(price.max) ? price.max : undefined,
            sort: sort && sort !== 'discount' ? sort : undefined,
          };

          const res = await axios.get('http://localhost:5228/api/product/filter', { params });
          productList = res.data.data;
        }

        if (sort === 'discount') {
          productList = productList
            .filter((p) => p.price2 && p.price2 < p.price1)
            .sort((a, b) => {
              const discountA = (a.price1 - a.price2) / a.price1;
              const discountB = (b.price1 - b.price2) / b.price1;
              return discountB - discountA;
            });
        }

        setProducts(productList);
        setCurrentPage(1);
      } catch (err) {
        console.error('❌ Lỗi khi gọi API:', err);
        toast.error('Không thể tải danh sách sản phẩm');
      }
    };

    fetchProducts();
  }, [category, price, sort, keyword]); // 👈 thêm keyword

  const paginatedData = products.slice(
    (currentPage - 1) * getItemsPerPage(),
    currentPage * getItemsPerPage()
  );

  const totalPages = Math.ceil(products.length / getItemsPerPage());

  const handleAddToCart = (product) => {
    const user = JSON.parse(localStorage.getItem('user'));

    if (!user) {
      toast.warn("Vui lòng đăng nhập để thêm vào giỏ hàng.");
      localStorage.setItem('redirectAfterLogin', window.location.pathname);
      navigate('/login');
      return;
    }

    const cartItem = {
      userId: user.userId,
      productId: product.productId,
      productName: product.name,
      quantity: 1,
      price: product.price2 && product.price2 < product.price1 ? product.price2 : product.price1,
      urlImage: product.urlImage1,
    };

    axios
      .post('http://localhost:5228/api/cart/add', cartItem)
      .then((res) => {
        toast.success(res.data.message || 'Đã thêm vào giỏ hàng');
        if (onAddToCartPopup) onAddToCartPopup();
      })
      .catch((err) => {
        console.error('Lỗi thêm giỏ hàng:', err);
        toast.error('Thêm vào giỏ hàng thất bại!');
      });
  };

  const calculateDiscount = (original, current) => {
    if (!original || !current || current >= original) return null;
    return Math.round(((original - current) / original) * 100);
  };

  return (
    <div className="product-page">
      <div className="sidebar">
        <ProductFilter
          onCategoryChange={setCategory}
          onPriceChange={(type, value) =>
            setPrice((prev) => ({ ...prev, [type]: value }))
          }
          onResetAll={resetAllFilters}
        />
        <HighlightList />
      </div>

      <div className="content-area">
        <div className="top-controls">
          <div className="sort-options">
            <label>Sắp xếp theo:</label>
            <select onChange={(e) => setSort(e.target.value)} value={sort}>
              <option value="">Mặc định</option>
              <option value="name_asc">Tên sản phẩm A - Z</option>
              <option value="name_desc">Tên sản phẩm Z - A</option>
              <option value="price_asc">Giá tăng dần</option>
              <option value="price_desc">Giá giảm dần</option>
              <option value="discount">Hàng khuyến mãi</option>
            </select>
          </div>

          <div className="view-mode-toggle">
            <label>Kiểu xem</label>
            <button
              onClick={() => setViewMode('grid3')}
              title="Lưới 3"
              className={viewMode === 'grid3' ? 'active' : ''}
            >
              ▦
            </button>
            <button
              onClick={() => setViewMode('grid2')}
              title="Lưới 2"
              className={viewMode === 'grid2' ? 'active' : ''}
            >
              ◪
            </button>
          </div>
        </div>

        <div className={`product-list ${viewMode}`}>
          {paginatedData.map((p) => {
            const discounted = p.price2 && p.price2 < p.price1;
            const finalPrice = discounted ? p.price2 : p.price1;
            const discount = calculateDiscount(p.price1, p.price2);

            return (
              <div className="product-card" key={p.productId}>
                {discounted && <div className="badge">-{discount}%</div>}

                <div
                  className="image-wrap"
                  style={{ cursor: 'pointer' }}
                  onClick={() => navigate(`/products/${p.productId}`)}
                >
                  <img
                    src={p.urlImage1 || 'https://via.placeholder.com/150'}
                    alt={p.name}
                  />
                </div>

                <div className="info">
                  <h3
                    style={{ cursor: 'pointer' }}
                    onClick={() => navigate(`/products/${p.productId}`)}
                  >
                    {p.name}
                  </h3>

                  <div className="price-wrapper">
                    <span className="product-price">
                      {finalPrice.toLocaleString('vi-VN')} ₫
                    </span>
                    {discounted && (
                      <span className="product-original">
                        {p.price1.toLocaleString('vi-VN')} ₫
                      </span>
                    )}
                  </div>

                  <button onClick={() => handleAddToCart(p)}>Thêm vào giỏ hàng</button>
                </div>
              </div>
            );
          })}
        </div>

        <div className="pagination">
          <button onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}>
            ◀
          </button>
          {Array.from({ length: totalPages }, (_, i) => (
            <button
              key={i}
              className={currentPage === i + 1 ? 'active' : ''}
              onClick={() => setCurrentPage(i + 1)}
            >
              {i + 1}
            </button>
          ))}
          <button
            onClick={() => setCurrentPage((prev) => Math.min(prev + 1, totalPages))}
          >
            ▶
          </button>
        </div>
      </div>
    </div>
  );
};

export default ProductCatalog;
