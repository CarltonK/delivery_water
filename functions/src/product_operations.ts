import * as functions from 'firebase-functions';
import { db } from './index';

export const identifyProduct = functions.runWith({
    memory: '512MB',
    timeoutSeconds: 30,
}).region('europe-west3').firestore
    .document('/users/{user}/products/{product}')
    .onCreate(async snapshot => {
        const supplier: string = snapshot.get('supplier')
        const id: string = snapshot.id
        if (supplier !== null) {
            try {
                const supplierDoc = await db.collection('users').doc(supplier).get()
                const fullName: string = supplierDoc.get('fullName')
                const phone: string = supplierDoc.get('phone')
                const location: Map<string, any> = supplierDoc.get('location')

                await db.collection('users').doc(supplier).collection('products').doc(id)
                    .update({
                        id: id,
                        createTime: snapshot.createTime,
                        details: {
                            'fullName': fullName,
                            'phone': phone,
                            'location': location
                        }
                    })
                console.log(`You have updated a product by ${supplier} as ${snapshot.id}`)
            } catch (error) {
                console.error(`identifyProduct ERROR -> ${error}`)
            }
        }
    })
