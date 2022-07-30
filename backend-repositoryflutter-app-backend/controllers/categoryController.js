import Category from '../models/categoryModel.js'
import asyncHandler from 'express-async-handler'


// @desc    Create new Category
// @route   POST /api/categories
// @access  Private
const addCategory = asyncHandler(async (req, res) => {
  const { name, description } = req.body

  if (name=='' || description=='') {
   return res.status(400).json({
        success: false,
        error: 'Please enter all fields',
    })
   
  } else {
    await Category({ name, description }).save()
    res.status(201).json({
        success: true,
        error:''
    })
  }
})

// @desc    Get Category by ID
// @route   GET /api/categories/:id
// @access  Private
const getCategoryById = asyncHandler(async (req, res) => {
  const Category = await Category.findById(req.params.id).populate(
    'user',
    'name email'
  )

  if (Category) {
    res.json(Category)
  } else {
    res.status(404)
    throw new Error('Category not found')
  }
})


// @desc    Get all categories
// @route   GET /api/categories
// @access  Private/Admin
const getcategories = asyncHandler(async (req, res) => {
  const categories = await Category.find({})
  return res.status(200).json({
    success: true,
    categories: categories,
    msg:''
  })
})

export {
  addCategory,
  getCategoryById,
  getcategories,
}