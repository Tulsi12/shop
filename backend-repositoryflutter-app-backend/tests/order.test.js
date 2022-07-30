const mongoose = require('mongoose');
const Order  = require('../Models/orderModelTest');
// use the new name of the database
const url = 'mongodb://localhost:27017/jestdatabase';
beforeAll(async () => {
 await mongoose.connect(url, {
 useNewUrlParser: true,
 useCreateIndex: true
 });
});
afterAll(async () => {
 await mongoose.connection.close();
});
describe('Product Schema test anything', () => {
// the code below is for insert testing
 it('Add Product testing anything', () => {
 const product = {
    "taxPrice":360,
    "shippingPrice":0,
    "totalPrice":2760,
    "isPaid":true,
    "isDelivered":true,
    "orderItems":[
        {
            "product":"6210b6db590daf37fccbd159",
            "name":"Cron Top","image":"/uploads\\image-1645262527286.jpg",
            "price":1200,"qty":2
        }
    ],
    "user":"6210b5a71af07e4b10acc603",
    "shippingAddress":{"address":"Kathmandu","city":"KT","postalCode":"132","country":"nep"},
    "paymentMethod":"Esewa",
    "paidAt":"2022-02-19T16:30:35.187Z",
    "paymentResult":{"id":null,"status":null,"update_time":null,"email_address":"default@mail.com"},
    "deliveredAt":"2022-02-19T16:51:26.937Z"
 };
 
 return Order.create(product)
 .then((pro_ret) => {
 expect(pro_ret.isPaid).toEqual(true);
 });
 });

it('to test the update user schema', async () => {
    return Order.findOneAndUpdate({"user":"6210b5a71af07e4b10acc603"}, {paymentMethod:'PayPal'}, {
        runValidators: false,
        new: true,
      })
    .then((pp)=>{
    expect(pp.paymentMethod).toEqual('PayPal')
    })
    
   });

   // the code below is for delete testing
 it('to test the delete user is working or not', async () => {
 const status = await Order.deleteMany();
 expect(status.ok).toBe(1);
});

})
