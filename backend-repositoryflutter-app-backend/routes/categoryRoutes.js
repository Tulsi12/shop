import express from 'express'
const router = express.Router()
import { addCategory, getCategoryById, getcategories } from '../controllers/categoryController.js'
import { protect, admin } from '../middleware/authMiddleware.js'

router.route('/').post(protect, admin, addCategory).get(protect, getcategories)

export default router
