const mongoose = require('mongoose');
const Product  = require('../Models/productModelTest');
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
 'name': 'Thong',
 'description': 'comfyyyy!!',
 'category':'Inner wear',
 'brand':'SUGAR',
 'image':'images',
 'user':'61a5d2e2212c3032d4d44cbb'
 };
 
 return Product.create(product)
 .then((pro_ret) => {
 expect(pro_ret.name).toEqual('Thong');
 });
 });

it('to test the update user schema', async () => {
    return Product.findOneAndUpdate({name:"Thong"}, {name:'Bra'}, {
        runValidators: false,
        new: true,
      })
    .then((pp)=>{
    expect(pp.name).toEqual('Bra')
    })
    
   });

   // the code below is for delete testing
 it('to test the delete user is working or not', async () => {
 const status = await Product.deleteMany();
 expect(status.ok).toBe(1);
});

})
