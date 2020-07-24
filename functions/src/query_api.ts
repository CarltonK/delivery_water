import * as express from 'express'
import * as functions from 'firebase-functions'
import {db} from './index'

interface Product {
    category: string,
    description: string,
    id: string,
    price: number,
    quantity: number,
    title: string,
    supplier: string
}

const app = express()
const main = express()

main.use('/api/v1', app)
main.use(express.json())

export const NaquaMain = functions.region('europe-west3').https.onRequest(main)

/*
!!!---GET---!!!
*/
app.post('/products', async (request, response) => {
    try {
        //PLACEHOLDER
        const products: any[] = []

        const cat: string[] = request.body['category']
        console.log(`The category is -> ${cat}`)

        if (!cat || cat === null) {
            console.log('Please specify a category')
            response.status(400).json({
                status: false,
                message: 'Please specify a category'
            })
        }

        const productQuery = await db.collectionGroup('products')
            .where('category','in', cat)
            .orderBy('price','desc')
            .get()
        const productQueryDocs = productQuery.docs
        console.log(`Products found are -> ${productQueryDocs.length}`)

        productQueryDocs.forEach(async (doc) => {
            const product: Product = doc.data() as Product
            if (product.supplier !== null) {

                const supplierDoc = await db.collection('users').doc(product.supplier).get()
                const fullName: string = supplierDoc.get('fullName')
                const phone: string = supplierDoc.get('phone')
                const location: Map<string, any> = supplierDoc.get('location')

                const object: Map<string, any> = new Map<string, any>()
                object.set('user', {
                    'fullName': fullName,
                    'phone': phone,
                    'location': location
                })
                object.set('product', product)
                console.log(`Object -> ${object.get('user')}`)

                products.push(product)
            }
        })

        response.status(200).json({
            status: true,
            message: 'success',
            data: products
        })
    } catch (error) {
        response.status(400).json({
            status: false,
            message: `${error}`
        })
    }
})