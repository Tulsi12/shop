// use the path of your model
const User = require('../Models/userModelTest');

const mongoose = require('mongoose');
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
describe('User Schema test anything', () => {
// the code below is for insert testing
 it('Add User testing anything', () => {
 const user = {
 'name': 'Nokia',
 'email': 'asgb@gmail.com',
 'password':'12345678'
 };
 
 return User.create(user)
 .then((pro_ret) => {
 expect(pro_ret.name).toEqual('Nokia');
 });
 });

it('to test the update user schema', async () => {
    return User.findOneAndUpdate({name:"Nokia"}, {name:'ram'}, {
        runValidators: false,
        new: true,
      })
    .then((pp)=>{
    expect(pp.name).toEqual('ram')
    })
    
   });

   // the code below is for delete testing
 it('to test the delete user is working or not', async () => {
 const status = await User.deleteMany();
 expect(status.ok).toBe(1);
});

})
