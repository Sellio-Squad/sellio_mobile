/* ═══════════════════════════════════════════════
   Mock Data — products, stores, categories
   ═══════════════════════════════════════════════ */

var CATEGORIES = [
  { name: 'Electronics', img: 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=112&h=112&fit=crop', bg: '#F0F4FF' },
  { name: 'Fashion', img: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=112&h=112&fit=crop', bg: '#FFF0F4' },
  { name: 'Home', img: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=112&h=112&fit=crop', bg: '#F0FFF4' },
  { name: 'Beauty', img: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=112&h=112&fit=crop', bg: '#FFF8F0' },
  { name: 'Sports', img: 'https://images.unsplash.com/photo-1461896836934-bd45ba8b0e28?w=112&h=112&fit=crop', bg: '#F0F8FF' },
  { name: 'Books', img: 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=112&h=112&fit=crop', bg: '#F8F0FF' },
  { name: 'Toys', img: 'https://images.unsplash.com/photo-1558060370-d644479cb6f7?w=112&h=112&fit=crop', bg: '#FFFBF0' },
  { name: 'More', isMore: true, bg: '#F5F5F5' }
];

var PRODUCTS = [
  { id: 1, title: 'Wireless Bluetooth Headphones', price: '299', originalPrice: '450', discount: '33%', category: 'Electronics', img: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=320&h=320&fit=crop', favorited: false },
  { id: 2, title: 'Classic Denim Jacket', price: '189', originalPrice: '250', discount: '24%', category: 'Fashion', img: 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=320&h=320&fit=crop', favorited: true },
  { id: 3, title: 'Stainless Steel Water Bottle', price: '79', originalPrice: null, discount: null, category: 'Home', img: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=320&h=320&fit=crop', favorited: false },
  { id: 4, title: 'Running Sneakers Pro', price: '450', originalPrice: '600', discount: '25%', category: 'Sports', img: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=320&h=320&fit=crop', favorited: false },
  { id: 5, title: 'Organic Face Cream', price: '125', originalPrice: null, discount: null, category: 'Beauty', img: 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=320&h=320&fit=crop', favorited: false },
  { id: 6, title: 'Smart Watch Series 5', price: '899', originalPrice: '1200', discount: '25%', category: 'Electronics', img: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=320&h=320&fit=crop', favorited: true },
  { id: 7, title: 'Canvas Backpack - Urban', price: '350', originalPrice: null, discount: null, category: 'Fashion', img: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=320&h=320&fit=crop', favorited: false },
  { id: 8, title: 'Ceramic Coffee Mug Set', price: '95', originalPrice: null, discount: null, category: 'Home', img: 'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=320&h=320&fit=crop', favorited: false },
  { id: 9, title: 'Yoga Mat Premium', price: '220', originalPrice: null, discount: '10%', category: 'Sports', img: 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=320&h=320&fit=crop', favorited: false },
  { id: 10, title: 'Bestseller Novel Collection', price: '75', originalPrice: null, discount: null, category: 'Books', img: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=320&h=320&fit=crop', favorited: false },
  { id: 11, title: 'Building Blocks Set', price: '150', originalPrice: null, discount: '30%', category: 'Toys', img: 'https://images.unsplash.com/photo-1587654780291-39c9404d7dd0?w=320&h=320&fit=crop', favorited: false },
  { id: 12, title: 'Wireless Phone Charger', price: '199', originalPrice: null, discount: null, category: 'Electronics', img: 'https://images.unsplash.com/photo-1615526675159-e0481f089953?w=320&h=320&fit=crop', favorited: false }
];

var STORES = [
  { id: 1, name: 'Tech World Electronics', discount: '15', bg: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', img: 'https://images.unsplash.com/photo-1531297484001-80022131f5a1?w=600&h=266&fit=crop', favorited: false },
  { id: 2, name: 'Fashion Hub Outlet', discount: null, bg: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)', img: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=600&h=266&fit=crop', favorited: true },
  { id: 3, name: 'Home Essentials Store', discount: '10', bg: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)', img: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=600&h=266&fit=crop', favorited: false }
];

var STORE_DETAIL = {
  id: 1,
  name: 'Tech World Electronics',
  coverImage: 'https://images.unsplash.com/photo-1531297484001-80022131f5a1?w=800&h=380&fit=crop',
  profileImage: 'https://images.unsplash.com/photo-1531297484001-80022131f5a1?w=200&h=200&fit=crop',
  description: 'Your one-stop shop for the latest electronics, gadgets, and accessories. We offer competitive prices and genuine products with warranty.',
  address: { country: 'Egypt', city: 'Cairo' },
  rating: 4.5,
  sale: '15',
  isFavorite: false,
  categories: [
    { id: 'all', name: 'All' },
    { id: 'phones', name: 'Phones' },
    { id: 'laptops', name: 'Laptops' },
    { id: 'accessories', name: 'Accessories' },
    { id: 'audio', name: 'Audio' }
  ],
  products: [
    { id: 101, title: 'Wireless Bluetooth Headphones', description: 'Premium noise-cancelling over-ear headphones', price: 299, images: ['https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'audio'] },
    { id: 102, title: 'Smart Watch Series 5', description: 'Latest smartwatch with health tracking', price: 899, images: ['https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'accessories'] },
    { id: 103, title: 'Wireless Phone Charger', description: 'Fast wireless charging pad for all devices', price: 199, images: ['https://images.unsplash.com/photo-1615526675159-e0481f089953?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'accessories'] },
    { id: 104, title: 'Laptop Pro 16"', description: 'High-performance laptop for professionals', price: 4500, images: ['https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'laptops'] },
    { id: 105, title: 'USB-C Hub Adapter', description: '7-in-1 USB-C hub with HDMI output', price: 250, images: ['https://images.unsplash.com/photo-1625842268584-8f3296236761?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'accessories'] },
    { id: 106, title: 'Wireless Earbuds Pro', description: 'Compact earbuds with active noise cancellation', price: 450, images: ['https://images.unsplash.com/photo-1590658268037-6bf12f032f55?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'audio'] },
    { id: 107, title: 'Smartphone Galaxy S24', description: 'Latest flagship smartphone with AI features', price: 3200, images: ['https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'phones'] },
    { id: 108, title: 'Portable Power Bank', description: '20000mAh fast charging power bank', price: 350, images: ['https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'accessories'] }
  ],
  featuredProducts: [
    { id: 201, title: 'iPhone 15 Pro Max', description: 'Apple latest titanium smartphone', price: 57000, images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'phones'] },
    { id: 202, title: 'MacBook Air M3', description: 'Thin and light laptop with M3 chip', price: 42000, images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'laptops'] }
  ]
};

var THRIFT_PRODUCTS = [
  { id: 1, title: 'Wireless Bluetooth Headphones', price: '299', image: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=320&h=352&fit=crop&auto=format', category: 'electronics', discount: '33% OFF', isFavorite: false },
  { id: 2, title: "Men's Casual Denim Jacket", price: '450', image: 'https://images.unsplash.com/photo-1516257984-b1b4d707412e?w=320&h=352&fit=crop&auto=format', category: 'fashion', discount: null, isFavorite: true },
  { id: 3, title: 'Stainless Steel Water Bottle', price: '120', image: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=320&h=352&fit=crop&auto=format', category: 'home', discount: '15% OFF', isFavorite: false },
  { id: 4, title: 'Running Sneakers Pro', price: '899', image: 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=320&h=352&fit=crop&auto=format', category: 'sports', discount: null, isFavorite: false },
  { id: 5, title: 'Organic Face Cream', price: '185', image: 'https://images.unsplash.com/photo-1611930022073-b7a4ba5fcccd?w=320&h=352&fit=crop&auto=format', category: 'beauty', discount: '20% OFF', isFavorite: false },
  { id: 6, title: 'Smartwatch Series X', price: '1200', image: 'https://images.unsplash.com/photo-1546868871-af0de0ae72be?w=320&h=352&fit=crop&auto=format', category: 'electronics', discount: null, isFavorite: false },
  { id: 7, title: 'Canvas Backpack - Urban', price: '350', image: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=320&h=352&fit=crop&auto=format', category: 'fashion', discount: '25% OFF', isFavorite: true },
  { id: 8, title: 'Ceramic Coffee Mug Set', price: '95', image: 'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=320&h=352&fit=crop&auto=format', category: 'home', discount: null, isFavorite: false },
  { id: 9, title: 'Yoga Mat Premium', price: '220', image: 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=320&h=352&fit=crop&auto=format', category: 'sports', discount: '10% OFF', isFavorite: false },
  { id: 10, title: 'Bestseller Novel Collection', price: '75', image: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=320&h=352&fit=crop&auto=format', category: 'books', discount: null, isFavorite: false },
  { id: 11, title: 'Building Blocks Set', price: '150', image: 'https://images.unsplash.com/photo-1587654780291-39c9404d7dd0?w=320&h=352&fit=crop&auto=format', category: 'toys', discount: '30% OFF', isFavorite: false },
  { id: 12, title: 'Wireless Phone Charger', price: '199', image: 'https://images.unsplash.com/photo-1615526675159-e0481f089953?w=320&h=352&fit=crop&auto=format', category: 'electronics', discount: null, isFavorite: false }
];
