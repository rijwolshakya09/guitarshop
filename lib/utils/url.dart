const baseUrl = "http://10.0.2.2:90/";
// const baseUrl = "http://localhost:90/";
// const baseUrl = "http://192.168.31.233:90/";
const loginUrl = "customer/login";
const registerUrl = "customer/register";
const categoryUrl = "guitarcategory/get";
const guitarUrl = "guitar/get";
const guitarSingleUrl = "guitar/getSingleguitar/";
const blogUrl = "blog/get";
const blogSingleUrl = "blog/getSingleBlog/";
const profileUrl = "customer/dashboard";

// Cart URL
const cartUrl = "cart/get";
const addcartUrl = "cart/insert";
const deleteCartUrl = "cart/delete/";
// Wishlist URL
const wishlistUrl = "wishlist/insert";
const getwishlistUrl = "wishlist/get";
const deleteWishlistUrl = "wishlist/delete/";
// Order URL
const addorderUrl = "order/insert";
const getorderUrl = "order/getUserOrder";
const cancelorderUrl = "order/cancel";
const deleteorderUrl = "order/delete/";
// Review URL
const addreviewUrl = "review/insert";
const getreviewUrl = "review/get/";
const deletereviewUrl = "review/delete/";

// Profile Update
const updatePatientProfileUrl = "customer/update/get";

String? token;
