import * as functions from 'firebase-functions'
import {db, ff} from'./index'

export const newOrder = functions.region('europe-west3').firestore
    .document('/orders/{order}')
    .onCreate(async snapshot => {
        const batch = db.batch()
        try {
            // Update USER
            const client = snapshot.get('client')
            const clientRef = db.collection('users').doc(client)
            batch.update(clientRef, {
                orderCount: ff.FieldValue.increment(1)
            })

            // Update ORDER
            const orderRef = db.collection('orders').doc(snapshot.id)
            const suppliers: string[] = []
            const products: any[] = snapshot.get('products')
            products.forEach(product => {
                const supplier: string = product['supplier']
                if (!suppliers.includes(supplier)) {
                    suppliers.push(supplier)
                }
            })
            batch.update(orderRef, {
                suppliers: suppliers
            })

            await batch.commit()
        } catch (error) {
            throw error
        }
    })