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
  { name: 'Automotive', img: 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=112&h=112&fit=crop', bg: '#F0F0FF' },
  { name: 'Baby & Kids', img: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=112&h=112&fit=crop', bg: '#FFF0F8' },
  { name: 'Garden', img: 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=112&h=112&fit=crop', bg: '#F0FFF0' },
  { name: 'Health', img: 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=112&h=112&fit=crop', bg: '#F5F0FF' },
  { name: 'Music', img: 'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=112&h=112&fit=crop', bg: '#FFF5F0' },
  { name: 'Pet Supplies', img: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=112&h=112&fit=crop', bg: '#FFF8F0' },
  { name: 'Art & Crafts', img: 'https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=112&h=112&fit=crop', bg: '#FFF0FF' },
  { name: 'Gaming', img: 'https://images.unsplash.com/photo-1612287230202-1ff1d85d1bdf?w=112&h=112&fit=crop', bg: '#F0F0FF' },
  { name: 'Jewelry', img: 'https://images.unsplash.com/photo-1515562141589-67f0d93e6b53?w=112&h=112&fit=crop', bg: '#FFFBF0' },
  { name: 'Furniture', img: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=112&h=112&fit=crop', bg: '#F5F0FF' },
  { name: 'Kitchen', img: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=112&h=112&fit=crop', bg: '#F0F8FF' },
  { name: 'Office', img: 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=112&h=112&fit=crop', bg: '#F0F4FF' },
  { name: 'Collectibles', img: 'https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?w=112&h=112&fit=crop', bg: '#FFF8E0' },
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

var STORE_DETAILS = {
  1: {
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
    ],
    about: {
      rating: { averageRating: 4.5, totalReviews: 128, ratingDistribution: { 5: 72, 4: 35, 3: 12, 2: 5, 1: 4 } },
      contactInfoList: [
        { type: 'phone', title: 'Phone', provider: '+20 123 456 7890' },
        { type: 'whatsapp', title: 'WhatsApp', provider: '+20 123 456 7890' },
        { type: 'email', title: 'Email', provider: 'techworld@example.com' },
        { type: 'facebook', title: 'Facebook', provider: 'Tech World Electronics' },
        { type: 'website', title: 'Website', provider: 'www.techworld.com' }
      ],
      address: { fullAddress: '15 Ramadan Street, Heliopolis, Cairo, Egypt', latitude: 29.8750, longitude: 31.3350 }
    }
  },
  2: {
    id: 2,
    name: 'Fashion Hub Outlet',
    coverImage: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&h=380&fit=crop',
    profileImage: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=200&h=200&fit=crop',
    description: 'Trendy fashion for men and women. Browse the latest collections from top brands at unbeatable prices.',
    address: { country: 'Egypt', city: 'Alexandria' },
    rating: 4.2,
    sale: null,
    isFavorite: true,
    categories: [
      { id: 'all', name: 'All' },
      { id: 'men', name: 'Men' },
      { id: 'women', name: 'Women' },
      { id: 'shoes', name: 'Shoes' },
      { id: 'accessories', name: 'Accessories' }
    ],
    products: [
      { id: 301, title: 'Classic Denim Jacket', description: 'Vintage wash denim jacket with button closure', price: 450, images: ['https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'men'] },
      { id: 302, title: 'Floral Summer Dress', description: 'Lightweight floral print midi dress', price: 380, images: ['https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'women'] },
      { id: 303, title: 'Leather Crossbody Bag', description: 'Genuine leather crossbody with adjustable strap', price: 520, images: ['https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'accessories'] },
      { id: 304, title: 'White Sneakers', description: 'Clean minimalist white leather sneakers', price: 650, images: ['https://images.unsplash.com/photo-1549298916-b41d501d3772?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'shoes'] },
      { id: 305, title: 'Slim Fit Chinos', description: 'Stretch cotton chinos in khaki', price: 290, images: ['https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'men'] },
      { id: 306, title: 'Oversized Sunglasses', description: 'UV400 polarized oversized frames', price: 180, images: ['https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'accessories'] },
      { id: 307, title: 'Knit Pullover Sweater', description: 'Soft ribbed knit pullover in navy', price: 340, images: ['https://images.unsplash.com/photo-1434389677669-e08b4cda3a98?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'women'] },
      { id: 308, title: 'Canvas Low-Top Sneakers', description: 'Casual canvas sneakers in olive green', price: 220, images: ['https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'shoes'] }
    ],
    featuredProducts: [
      { id: 401, title: 'Designer Trench Coat', description: 'Premium belted trench coat in beige', price: 1200, images: ['https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'women'] },
      { id: 402, title: 'Premium Leather Boots', description: 'Handcrafted ankle boots in brown leather', price: 1800, images: ['https://images.unsplash.com/photo-1638247025967-b4e38f787b76?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'shoes'] }
    ],
    about: {
      rating: { averageRating: 4.2, totalReviews: 85, ratingDistribution: { 5: 40, 4: 25, 3: 10, 2: 6, 1: 4 } },
      contactInfoList: [
        { type: 'phone', title: 'Phone', provider: '+20 109 876 5432' },
        { type: 'whatsapp', title: 'WhatsApp', provider: '+20 109 876 5432' },
        { type: 'email', title: 'Email', provider: 'info@fashionhub.com' },
        { type: 'facebook', title: 'Facebook', provider: 'Fashion Hub Outlet' },
        { type: 'website', title: 'Website', provider: 'www.fashionhub.com' }
      ],
      address: { fullAddress: '23 El Corniche Road, Smouha, Alexandria, Egypt', latitude: 31.2001, longitude: 29.9187 }
    }
  },
  3: {
    id: 3,
    name: 'Home Essentials Store',
    coverImage: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&h=380&fit=crop',
    profileImage: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=200&h=200&fit=crop',
    description: 'Everything for your home — kitchen, decor, bedding, and bath. Quality products at affordable prices.',
    address: { country: 'Egypt', city: 'Giza' },
    rating: 4.7,
    sale: '10',
    isFavorite: false,
    categories: [
      { id: 'all', name: 'All' },
      { id: 'kitchen', name: 'Kitchen' },
      { id: 'decor', name: 'Decor' },
      { id: 'bedding', name: 'Bedding' },
      { id: 'bath', name: 'Bath' }
    ],
    products: [
      { id: 501, title: 'Ceramic Dinner Set', description: '16-piece ceramic dinnerware set in matte white', price: 780, images: ['https://images.unsplash.com/photo-1556909114-44e3e70034e2?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'kitchen'] },
      { id: 502, title: 'Memory Foam Pillow', description: 'Ergonomic memory foam pillow with cooling gel', price: 320, images: ['https://images.unsplash.com/photo-1592789705501-f4ff223a08db?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'bedding'] },
      { id: 503, title: 'Scented Candle Set', description: 'Pack of 3 hand-poured soy wax candles', price: 250, images: ['https://images.unsplash.com/photo-1602607682525-ad8a1ef83d1c?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'decor'] },
      { id: 504, title: 'Stainless Steel Cookware', description: '5-piece non-stick cookware set', price: 1200, images: ['https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'kitchen'] },
      { id: 505, title: 'Turkish Cotton Towels', description: 'Set of 4 bath towels in soft cotton', price: 420, images: ['https://images.unsplash.com/photo-1563453392212-326f5e854473?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'bath'] },
      { id: 506, title: 'Throw Blanket', description: 'Chunky knit throw blanket in cream', price: 350, images: ['https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'decor'] },
      { id: 507, title: 'Bamboo Cutting Board', description: 'Large bamboo board with juice groove', price: 180, images: ['https://images.unsplash.com/photo-1594226801341-41427b4e5c22?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'kitchen'] },
      { id: 508, title: 'Egyptian Cotton Sheet Set', description: '1000TC Egyptian cotton sheets, queen size', price: 890, images: ['https://images.unsplash.com/photo-1522771739813-958636b8b3df?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'bedding'] }
    ],
    featuredProducts: [
      { id: 601, title: 'Espresso Machine', description: 'Barista-grade espresso machine with milk frother', price: 3500, images: ['https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'kitchen'] },
      { id: 602, title: 'Weighted Blanket', description: 'Premium glass-bead weighted blanket 15lb', price: 750, images: ['https://images.unsplash.com/photo-1520923179278-54df2a8b98fb?w=320&h=320&fit=crop'], subCategoriesIds: ['all', 'bedding'] }
    ],
    about: {
      rating: { averageRating: 4.7, totalReviews: 210, ratingDistribution: { 5: 140, 4: 45, 3: 15, 2: 6, 1: 4 } },
      contactInfoList: [
        { type: 'phone', title: 'Phone', provider: '+20 115 555 1234' },
        { type: 'whatsapp', title: 'WhatsApp', provider: '+20 115 555 1234' },
        { type: 'email', title: 'Email', provider: 'hello@homeessentials.com' },
        { type: 'facebook', title: 'Facebook', provider: 'Home Essentials Store' },
        { type: 'website', title: 'Website', provider: 'www.homeessentials.com' }
      ],
      address: { fullAddress: '8 Mohandessin Street, Dokki, Giza, Egypt', latitude: 30.0380, longitude: 31.2119 }
    }
  }
};

function getStoreDetail(storeId) {
  return STORE_DETAILS[storeId] || STORE_DETAILS[1];
}

function getAboutStoreData(storeId) {
  var store = getStoreDetail(storeId);
  return store.about;
}

var PRODUCT_DETAILS = {
  1: { id: 1, title: 'Wireless Bluetooth Headphones', description: 'Premium noise-cancelling over-ear headphones with 30-hour battery life and crystal-clear audio quality.', price: 299, originalPrice: 450, discount: '33%', isFavorite: false, images: ['https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1583394838336-acd977736f90?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1484704849700-f032a568e944?w=400&h=400&fit=crop'], category: 'Electronics' },
  2: { id: 2, title: 'Classic Denim Jacket', description: 'Vintage wash denim jacket with button closure, perfect for all seasons.', price: 189, originalPrice: 250, discount: '24%', isFavorite: true, images: ['https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1516257984-b1b4d707412e?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1495105787522-5334e3ffa0ef?w=400&h=400&fit=crop'], category: 'Fashion' },
  3: { id: 3, title: 'Stainless Steel Water Bottle', description: 'Double-wall insulated 750ml bottle, keeps drinks cold for 24 hours or hot for 12.', price: 79, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1523365107298-315d5c1e1d23?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1570831739435-6601aa3fa4fb?w=400&h=400&fit=crop'], category: 'Home' },
  4: { id: 4, title: 'Running Sneakers Pro', description: 'Lightweight running shoes with cushion support and breathable mesh upper.', price: 450, originalPrice: 600, discount: '25%', isFavorite: false, images: ['https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=400&h=400&fit=crop'], category: 'Sports' },
  5: { id: 5, title: 'Organic Face Cream', description: 'Hydrating moisturizer with hyaluronic acid and organic botanical extracts.', price: 125, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1611930022073-b7a4ba5fcccd?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1570194065650-d99fb4ee4037?w=400&h=400&fit=crop'], category: 'Beauty' },
  6: { id: 6, title: 'Smart Watch Series 5', description: 'Latest smartwatch with health tracking, GPS, and always-on display.', price: 899, originalPrice: 1200, discount: '25%', isFavorite: true, images: ['https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1546868871-af0de0ae72be?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=400&h=400&fit=crop'], category: 'Electronics' },
  7: { id: 7, title: 'Canvas Backpack - Urban', description: 'Durable canvas backpack with laptop compartment and multiple pockets.', price: 350, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1581605405669-fcdf81165afa?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&h=400&fit=crop'], category: 'Fashion' },
  8: { id: 8, title: 'Ceramic Coffee Mug Set', description: 'Set of 4 handcrafted ceramic mugs in matte finish, dishwasher safe.', price: 95, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1517256673644-36ad11246d21?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=400&fit=crop'], category: 'Home' },
  9: { id: 9, title: 'Yoga Mat Premium', description: 'Non-slip eco-friendly yoga mat, 6mm thick with alignment guides.', price: 220, originalPrice: null, discount: '10%', isFavorite: false, images: ['https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1592432678016-e910b452f9a2?w=400&h=400&fit=crop'], category: 'Sports' },
  10: { id: 10, title: 'Bestseller Novel Collection', description: 'Collection of 3 bestselling novels from award-winning authors.', price: 75, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1512820790803-83ca734da794?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=400&h=400&fit=crop'], category: 'Books' },
  11: { id: 11, title: 'Building Blocks Set', description: '250-piece building blocks set with storage bag, compatible with major brands.', price: 150, originalPrice: null, discount: '30%', isFavorite: false, images: ['https://images.unsplash.com/photo-1587654780291-39c9404d7dd0?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1587654780291-39c9404d7dd0?w=400&h=400&fit=crop'], category: 'Toys' },
  12: { id: 12, title: 'Wireless Phone Charger', description: 'Fast 15W wireless charging pad compatible with all Qi-enabled devices.', price: 199, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1615526675159-e0481f089953?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1616400619175-5beda3a17896?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=400&h=400&fit=crop'], category: 'Electronics' },
  101: { id: 101, title: 'Wireless Bluetooth Headphones', description: 'Premium noise-cancelling over-ear headphones', price: 299, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1583394838336-acd977736f90?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1484704849700-f032a568e944?w=400&h=400&fit=crop'], category: 'Electronics' },
  102: { id: 102, title: 'Smart Watch Series 5', description: 'Latest smartwatch with health tracking', price: 899, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1546868871-af0de0ae72be?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=400&h=400&fit=crop'], category: 'Electronics' },
  103: { id: 103, title: 'Wireless Phone Charger', description: 'Fast wireless charging pad for all devices', price: 199, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1615526675159-e0481f089953?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1616400619175-5beda3a17896?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=400&h=400&fit=crop'], category: 'Electronics' },
  104: { id: 104, title: 'Laptop Pro 16"', description: 'High-performance laptop for professionals', price: 4500, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400&h=400&fit=crop'], category: 'Electronics' },
  105: { id: 105, title: 'USB-C Hub Adapter', description: '7-in-1 USB-C hub with HDMI output', price: 250, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1625842268584-8f3296236761?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1625842268584-8f3296236761?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1625842268584-8f3296236761?w=400&h=400&fit=crop'], category: 'Electronics' },
  106: { id: 106, title: 'Wireless Earbuds Pro', description: 'Compact earbuds with active noise cancellation', price: 450, originalPrice: 600, discount: '25%', isFavorite: false, images: ['https://images.unsplash.com/photo-1590658268037-6bf12f032f55?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1590658268037-6bf12f032f55?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1590658268037-6bf12f032f55?w=400&h=400&fit=crop'], category: 'Electronics' },
  107: { id: 107, title: 'Smartphone Galaxy S24', description: 'Latest flagship smartphone with AI features', price: 3200, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400&h=400&fit=crop'], category: 'Electronics' },
  108: { id: 108, title: 'Portable Power Bank', description: '20000mAh fast charging power bank', price: 350, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=400&h=400&fit=crop'], category: 'Electronics' },
  201: { id: 201, title: 'iPhone 15 Pro Max', description: 'Apple latest titanium smartphone', price: 57000, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400&h=400&fit=crop'], category: 'Electronics' },
  202: { id: 202, title: 'MacBook Air M3', description: 'Thin and light laptop with M3 chip', price: 42000, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400&h=400&fit=crop'], category: 'Electronics' },
  301: { id: 301, title: 'Classic Denim Jacket', description: 'Vintage wash denim jacket with button closure', price: 450, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1516257984-b1b4d707412e?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1495105787522-5334e3ffa0ef?w=400&h=400&fit=crop'], category: 'Fashion' },
  302: { id: 302, title: 'Floral Summer Dress', description: 'Lightweight floral print midi dress', price: 380, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=400&h=400&fit=crop'], category: 'Fashion' },
  303: { id: 303, title: 'Leather Crossbody Bag', description: 'Genuine leather crossbody with adjustable strap', price: 520, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400&h=400&fit=crop'], category: 'Fashion' },
  304: { id: 304, title: 'White Sneakers', description: 'Clean minimalist white leather sneakers', price: 650, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1549298916-b41d501d3772?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1549298916-b41d501d3772?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&h=400&fit=crop'], category: 'Fashion' },
  305: { id: 305, title: 'Slim Fit Chinos', description: 'Stretch cotton chinos in khaki', price: 290, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=400&h=400&fit=crop'], category: 'Fashion' },
  306: { id: 306, title: 'Oversized Sunglasses', description: 'UV400 polarized oversized frames', price: 180, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=400&h=400&fit=crop'], category: 'Fashion' },
  307: { id: 307, title: 'Knit Pullover Sweater', description: 'Soft ribbed knit pullover in navy', price: 340, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1434389677669-e08b4cda3a98?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1434389677669-e08b4cda3a98?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1434389677669-e08b4cda3a98?w=400&h=400&fit=crop'], category: 'Fashion' },
  308: { id: 308, title: 'Canvas Low-Top Sneakers', description: 'Casual canvas sneakers in olive green', price: 220, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=400&h=400&fit=crop'], category: 'Fashion' },
  401: { id: 401, title: 'Designer Trench Coat', description: 'Premium belted trench coat in beige', price: 1200, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=400&h=400&fit=crop'], category: 'Fashion' },
  402: { id: 402, title: 'Premium Leather Boots', description: 'Handcrafted ankle boots in brown leather', price: 1800, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1638247025967-b4e38f787b76?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1638247025967-b4e38f787b76?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1638247025967-b4e38f787b76?w=400&h=400&fit=crop'], category: 'Fashion' },
  501: { id: 501, title: 'Ceramic Dinner Set', description: '16-piece ceramic dinnerware set in matte white', price: 780, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1556909114-44e3e70034e2?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1556909114-44e3e70034e2?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1556909114-44e3e70034e2?w=400&h=400&fit=crop'], category: 'Home' },
  502: { id: 502, title: 'Memory Foam Pillow', description: 'Ergonomic memory foam pillow with cooling gel', price: 320, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1592789705501-f4f1a4d3d6d8?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1592789705501-f4f1a4d3d6d8?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1592789705501-f4f1a4d3d6d8?w=400&h=400&fit=crop'], category: 'Home' },
  503: { id: 503, title: 'Scented Candle Set', description: 'Pack of 3 hand-poured soy wax candles', price: 250, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1602607682525-ad8a1ef83d1c?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1602607682525-ad8a1ef83d1c?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1602607682525-ad8a1ef83d1c?w=400&h=400&fit=crop'], category: 'Home' },
  504: { id: 504, title: 'Stainless Steel Cookware', description: '5-piece non-stick cookware set', price: 1200, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&h=400&fit=crop'], category: 'Home' },
  505: { id: 505, title: 'Turkish Cotton Towels', description: 'Set of 4 bath towels in soft cotton', price: 420, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1563453392212-326f5e854473?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1563453392212-326f5e854473?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1563453392212-326f5e854473?w=400&h=400&fit=crop'], category: 'Home' },
  506: { id: 506, title: 'Throw Blanket', description: 'Chunky knit throw blanket in cream', price: 350, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&h=400&fit=crop'], category: 'Home' },
  507: { id: 507, title: 'Bamboo Cutting Board', description: 'Large bamboo board with juice groove', price: 180, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1594226801341-41427b4e5c22?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1594226801341-41427b4e5c22?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1594226801341-41427b4e5c22?w=400&h=400&fit=crop'], category: 'Home' },
  508: { id: 508, title: 'Egyptian Cotton Sheet Set', description: '1000TC Egyptian cotton sheets, queen size', price: 890, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1522771739813-958636b8b3df?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1522771739813-958636b8b3df?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1522771739813-958636b8b3df?w=400&h=400&fit=crop'], category: 'Home' },
  601: { id: 601, title: 'Espresso Machine', description: 'Barista-grade espresso machine with milk frother', price: 3500, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=400&h=400&fit=crop'], category: 'Home' },
  602: { id: 602, title: 'Weighted Blanket', description: 'Premium glass-bead weighted blanket 15lb', price: 750, originalPrice: null, discount: null, isFavorite: false, images: ['https://images.unsplash.com/photo-1520923179278-54df2a8b98fb?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1520923179278-54df2a8b98fb?w=320&h=320&fit=crop','https://images.unsplash.com/photo-1520923179278-54df2a8b98fb?w=400&h=400&fit=crop'], category: 'Home' }
};

function getProductDetail(id) {
  return PRODUCT_DETAILS[id] || PRODUCT_DETAILS[1];
}

var CATEGORY_DATA = {
  'Electronics': {
    subcategories: [
      { id: 'all', name: 'All' },
      { id: 'phones', name: 'Phones' },
      { id: 'laptops', name: 'Laptops' },
      { id: 'accessories', name: 'Accessories' },
      { id: 'audio', name: 'Audio' }
    ],
    products: [
      { id: 301, title: 'Wireless Bluetooth Headphones', description: 'Premium noise-cancelling over-ear headphones', price: 299, originalPrice: 450, discount: '33%', images: ['https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=320&h=320&fit=crop'], subcategories: ['all', 'audio'], isFavorite: false },
      { id: 302, title: 'Smart Watch Series 5', description: 'Latest smartwatch with health tracking', price: 899, originalPrice: 1200, discount: '25%', images: ['https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=320&h=320&fit=crop'], subcategories: ['all', 'accessories'], isFavorite: true },
      { id: 303, title: 'Wireless Phone Charger', description: 'Fast wireless charging pad for all devices', price: 199, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1615526675159-e0481f089953?w=320&h=320&fit=crop'], subcategories: ['all', 'accessories'], isFavorite: false },
      { id: 304, title: 'Smartphone Galaxy S24', description: 'Latest flagship smartphone with AI features', price: 3200, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=320&h=320&fit=crop'], subcategories: ['all', 'phones'], isFavorite: false },
      { id: 305, title: 'Laptop Pro 16"', description: 'High-performance laptop for professionals', price: 4500, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=320&h=320&fit=crop'], subcategories: ['all', 'laptops'], isFavorite: false },
      { id: 306, title: 'Wireless Earbuds Pro', description: 'Compact earbuds with active noise cancellation', price: 450, originalPrice: 600, discount: '25%', images: ['https://images.unsplash.com/photo-1590658268037-6bf12f032f55?w=320&h=320&fit=crop'], subcategories: ['all', 'audio'], isFavorite: false },
      { id: 307, title: 'USB-C Hub Adapter', description: '7-in-1 USB-C hub with HDMI output', price: 250, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1625842268584-8f3296236761?w=320&h=320&fit=crop'], subcategories: ['all', 'accessories'], isFavorite: false },
      { id: 308, title: 'Portable Power Bank', description: '20000mAh fast charging power bank', price: 350, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=320&h=320&fit=crop'], subcategories: ['all', 'accessories'], isFavorite: false }
    ]
  },
  'Fashion': {
    subcategories: [
      { id: 'all', name: 'All' },
      { id: 'men', name: 'Men' },
      { id: 'women', name: 'Women' },
      { id: 'shoes', name: 'Shoes' },
      { id: 'bags', name: 'Bags' }
    ],
    products: [
      { id: 311, title: 'Classic Denim Jacket', description: 'Vintage wash denim jacket for all seasons', price: 189, originalPrice: 250, discount: '24%', images: ['https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=320&h=320&fit=crop'], subcategories: ['all', 'men'], isFavorite: true },
      { id: 312, title: 'Canvas Backpack - Urban', description: 'Durable canvas backpack with laptop compartment', price: 350, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=320&h=320&fit=crop'], subcategories: ['all', 'bags'], isFavorite: false },
      { id: 313, title: 'Running Sneakers Pro', description: 'Lightweight running shoes with cushion support', price: 450, originalPrice: 600, discount: '25%', images: ['https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=320&h=320&fit=crop'], subcategories: ['all', 'shoes'], isFavorite: false },
      { id: 314, title: 'Summer Floral Dress', description: 'Elegant floral print maxi dress', price: 299, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=320&h=320&fit=crop'], subcategories: ['all', 'women'], isFavorite: false },
      { id: 315, title: 'Leather Crossbody Bag', description: 'Genuine leather crossbody with adjustable strap', price: 520, originalPrice: null, discount: '15%', images: ['https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=320&h=320&fit=crop'], subcategories: ['all', 'bags'], isFavorite: false },
      { id: 316, title: 'Casual Polo Shirt', description: 'Premium cotton polo in classic fit', price: 149, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1625910513413-5fc42fdaeb27?w=320&h=320&fit=crop'], subcategories: ['all', 'men'], isFavorite: false }
    ]
  },
  'Home': {
    subcategories: [
      { id: 'all', name: 'All' },
      { id: 'decor', name: 'Decor' },
      { id: 'kitchen', name: 'Kitchen' },
      { id: 'bedding', name: 'Bedding' }
    ],
    products: [
      { id: 321, title: 'Ceramic Coffee Mug Set', description: 'Set of 4 handcrafted ceramic mugs', price: 95, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=320&h=320&fit=crop'], subcategories: ['all', 'kitchen'], isFavorite: false },
      { id: 322, title: 'Stainless Steel Water Bottle', description: 'Double-wall insulated 750ml bottle', price: 79, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=320&h=320&fit=crop'], subcategories: ['all', 'kitchen'], isFavorite: false },
      { id: 323, title: 'Scented Candle Collection', description: 'Hand-poured soy wax candles set of 3', price: 120, originalPrice: 150, discount: '20%', images: ['https://images.unsplash.com/photo-1602028915047-37269d1a73f7?w=320&h=320&fit=crop'], subcategories: ['all', 'decor'], isFavorite: false },
      { id: 324, title: 'Memory Foam Pillow', description: 'Ergonomic cervical support pillow', price: 280, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1592789705501-f4f1a4d3d6d8?w=320&h=320&fit=crop'], subcategories: ['all', 'bedding'], isFavorite: false }
    ]
  },
  'Beauty': {
    subcategories: [
      { id: 'all', name: 'All' },
      { id: 'skincare', name: 'Skincare' },
      { id: 'makeup', name: 'Makeup' },
      { id: 'haircare', name: 'Haircare' }
    ],
    products: [
      { id: 331, title: 'Organic Face Cream', description: 'Hydrating moisturizer with hyaluronic acid', price: 125, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=320&h=320&fit=crop'], subcategories: ['all', 'skincare'], isFavorite: false },
      { id: 332, title: 'Vitamin C Serum', description: 'Brightening serum with 20% vitamin C', price: 189, originalPrice: 250, discount: '24%', images: ['https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=320&h=320&fit=crop'], subcategories: ['all', 'skincare'], isFavorite: false },
      { id: 333, title: 'Matte Lipstick Set', description: 'Long-lasting matte lipstick in 6 shades', price: 210, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1586495777744-4413f21062fa?w=320&h=320&fit=crop'], subcategories: ['all', 'makeup'], isFavorite: false }
    ]
  },
  'Sports': {
    subcategories: [
      { id: 'all', name: 'All' },
      { id: 'fitness', name: 'Fitness' },
      { id: 'outdoor', name: 'Outdoor' },
      { id: 'cycling', name: 'Cycling' }
    ],
    products: [
      { id: 341, title: 'Yoga Mat Premium', description: 'Non-slip eco-friendly yoga mat 6mm', price: 220, originalPrice: null, discount: '10%', images: ['https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=320&h=320&fit=crop'], subcategories: ['all', 'fitness'], isFavorite: false },
      { id: 342, title: 'Resistance Bands Set', description: 'Set of 5 bands with different resistance levels', price: 85, originalPrice: null, discount: null, images: ['https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=320&h=320&fit=crop'], subcategories: ['all', 'fitness'], isFavorite: false },
      { id: 343, title: 'Camping Tent 4-Person', description: 'Waterproof family camping tent', price: 890, originalPrice: 1200, discount: '25%', images: ['https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=320&h=320&fit=crop'], subcategories: ['all', 'outdoor'], isFavorite: false }
    ]
  }
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

/* ═══════════════════════════════════════════════
   Notifications — grouped by date, states: 0=placed, 1=delivered, 2=cancelled
   ═══════════════════════════════════════════════ */

var NOTIFICATIONS = [
  { id: 'n1', orderId: '#SL-20491', storeName: 'Tech World Electronics', state: 1, time: '14:30', date: new Date().toISOString().split('T')[0] },
  { id: 'n2', orderId: '#SL-20487', storeName: 'Fashion Hub Outlet', state: 0, time: '12:15', date: new Date().toISOString().split('T')[0] },
  { id: 'n3', orderId: '#SL-20480', storeName: 'Home Essentials Store', state: 2, time: '09:45', date: new Date().toISOString().split('T')[0] },
  { id: 'n4', orderId: '#SL-20465', storeName: 'Tech World Electronics', state: 0, time: '18:22', date: (function(){ var d = new Date(); d.setDate(d.getDate()-1); return d.toISOString().split('T')[0]; })() },
  { id: 'n5', orderId: '#SL-20452', storeName: 'Fashion Hub Outlet', state: 1, time: '11:05', date: (function(){ var d = new Date(); d.setDate(d.getDate()-1); return d.toISOString().split('T')[0]; })() },
  { id: 'n6', orderId: '#SL-20438', storeName: 'Home Essentials Store', state: 0, time: '08:30', date: (function(){ var d = new Date(); d.setDate(d.getDate()-3); return d.toISOString().split('T')[0]; })() },
  { id: 'n7', orderId: '#SL-20421', storeName: 'Tech World Electronics', state: 1, time: '16:40', date: (function(){ var d = new Date(); d.setDate(d.getDate()-3); return d.toISOString().split('T')[0]; })() },
  { id: 'n8', orderId: '#SL-20399', storeName: 'Fashion Hub Outlet', state: 2, time: '10:12', date: (function(){ var d = new Date(); d.setDate(d.getDate()-5); return d.toISOString().split('T')[0]; })() }
];

var NOTIFICATION_STATES = {
  0: { label: 'has been placed successfully', icon: 'placed' },
  1: { label: 'has been delivered successfully', icon: 'delivered' },
  2: { label: 'has been cancelled', icon: 'cancelled' }
};
