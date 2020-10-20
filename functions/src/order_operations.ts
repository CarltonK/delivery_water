import * as functions from 'firebase-functions'
import {db, ff} from'./index'
import * as notifcations from './notification_operations'
import * as https from 'https'
import { lipaNaMpesa } from './payments/mpesa/stk_push'

export const newOrder = functions.region('europe-west3').firestore
    .document('/orders/{order}')
    .onUpdate(async snapshot => {
        const batch = db.batch()
        try {
            const key = process.env.API_KEY
            // Get Location Name
            const oID = snapshot.after.id
            const total: number = snapshot.after.get('grandtotal')
            const client = snapshot.after.get('client')
            const coordinates = snapshot.after.get('location')

            const latitude: number = coordinates['latitude']
            const longitude: number = coordinates['longitude']

            const phone = await getUserPhone(client)
            if (typeof(phone) === 'number') {
                console.log(`M-PESA Transaction has been executed for Order No ${oID}`)
                await lipaNaMpesa(phone,total)
            }


            let deliveryLocation: string = ''
            https.get(`https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${latitude},${longitude}&radius=5000&type=sublocality&key=${key}`, (resp) => {
                const code: number | undefined = resp.statusCode
                if (code === 200) {
                    let data = '';
                    resp.on('data', (chunk) => {
                        data += chunk;
                    });
                    resp.on('end', async () => {
                        const parsedData = JSON.parse(data)
                        deliveryLocation = parsedData['results'][0]['name']
                        console.log(deliveryLocation)

                        // Update USER
                        const clientRef = db.collection('users').doc(client)
                        batch.update(clientRef, {
                            orderCount: ff.FieldValue.increment(1),
                        })

                        // Update ORDER
                        const orderRef = db.collection('orders').doc(oID)
                        const suppliers: string[] = []
                        const details: Map<string, string>[] = []
                        const products: any[] = snapshot.after.get('products')
                        products.forEach(product => {
                            // Send key info to avoid querying for the product document 
                            const supplier: string = product['supplier']
                            const title: string = product['title']
                            const count: number = product['count']
                            const obj = new Map()
                            obj.set('supplier', supplier)
                            obj.set('count',count)
                            obj.set('title',title)
                            details.push(obj)

                            // Update the order document with various suppliers
                            if (!suppliers.includes(supplier)) {
                                suppliers.push(supplier)
                            }
                        })
                        batch.update(orderRef, {
                            suppliers: suppliers,
                            transactionStatus: 'executed'
                        })

                        await batch.commit()

                        // Notifications -> They include updating the users notifications collection
                        // 1) Notification to client
                        const clientDoc = await db.collection('users').doc(client).get()
                        const clientToken: string = clientDoc.get('token')
                        await notifcations.singleNotificationSend(clientToken,`Your order has been received. Ref No. ${oID}`,'Good News')
                        await db.collection('users').doc(client).collection('notifications').doc().set({
                            time: ff.Timestamp.now(),
                            message: `Good News. Your order has been received. Ref No. ${oID}`
                        })
                        console.log(`A notification has been sent to the client ${client} for order with Ref No. ${oID}`)

                        // 2) Notification to suppliers
                        details.forEach(async (item: Map<string, string>) => {
                            const supplier: string | any = item.get('supplier')
                            const title: string | any = item.get('title')
                            const count: string | any = item.get('count')
                            // Notification content
                            const messageTitle: string = 'Good News'
                            const messageContent: string = `You have received an order for ${count} ${title} at ${deliveryLocation}`
                            // Get supplier document
                            const supplierDoc = await db.collection('users').doc(supplier).get()
                            const supplierToken: string = supplierDoc.get('token')
                            // Send notification
                            await notifcations.singleNotificationSend(supplierToken,messageContent,messageTitle)
                            await db.collection('users').doc(supplier).collection('notifications').doc().set({
                                time: ff.Timestamp.now(),
                                message: `You have received an order for ${count} ${title} at ${deliveryLocation}`
                            })
                        })
                        console.log(`A notification has been sent to the following suppliers ${suppliers} for order with Ref No. ${oID}`)
                    })
                } 
            });

            } catch (error) {
            throw error
        }
    })

async function getUserPhone(uid: string) {
    try {
        const doc = await db.collection('users').doc(uid).get()
        const phone: string | null = doc.get('phone')
        if (typeof (phone) === 'string') {
            const value: number = Number("254" + phone.slice(1))
            return value
        } else {
            return false
        }
    } catch (error) {
        console.error(error)
    }
    return false
}