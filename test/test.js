const assert = require('assert');
const firebase = require('@firebase/testing');
const { title } = require('process');

const PROJECT_ID = 'naqua-1b2bb';
const myID = "user_abc";
const theirID = "user_xyz";
const myAuth = {uid: myID, email: "abc@gmail.com"}
const theirAuth = {uid: theirID, email: "xyz@gmail.com"}

function getFirestore(auth) {
    return firebase.initializeTestApp({projectId: PROJECT_ID, auth: auth}).firestore();
}

function getAdminFirestore() {
    return firebase.initializeAdminApp({projectId: PROJECT_ID}).firestore();
}

describe('Naqua', () => {

    it("Can't write items in the private collection", async () => {
        const db = getFirestore(null);
        const testDoc = db.collection('private').doc('testDoc')
        await firebase.assertFails(testDoc.set({foo: "bar"}))
    })

    it("Can't read items from the private collection", async () => {
        const db = getFirestore(null);
        const testDoc = db.collection('private').doc('testDoc')
        await firebase.assertFails(testDoc.get())
    })


    it("Can't read a user document if user is not owner", async () => {
        const db = getFirestore(theirAuth);
        const userDoc = db.collection('users').doc(myID)
        await firebase.assertFails(userDoc.get())
    })

    it("Can't write a user document if user is not signed in", async () => {
        const db = getFirestore(null);
        const testDoc = db.collection('users').doc(myID);
        await firebase.assertFails(testDoc.set({foo: "bar"}))
    })

    it("Can't write a user document if user is not the owner", async () => {
        const db = getFirestore(theirAuth);
        const testDoc = db.collection('users').doc(myID);
        await firebase.assertFails(testDoc.set({foo: "bar"}))
    })

    it("Can't allow a user to delete their own document", async () => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection('users').doc(myID);
        await firebase.assertFails(testDoc.delete())
    })

    it("Can't allow a user to delete another users document", async () => {
        const db = getFirestore(theirAuth);
        const testDoc = db.collection('users').doc(myID);
        await firebase.assertFails(testDoc.delete())
    })

    it("Can write a user document if user is signed in and is owner", async () => {
        const db = getFirestore(myAuth)
        const testDoc = db.collection('users').doc(myID);
        await firebase.assertSucceeds(testDoc.set({foo: "bar"}))
    })

    it("Can't view a notification if not owner", async () => {
        const db = getFirestore(theirAuth);
        const testDoc = db.collection('users').doc(myID).collection('notifications').doc('not_one')
        await firebase.assertFails(testDoc.get());
    })

    it("Can view a notification if is owner", async () => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection('users').doc(myID).collection('notifications').doc('not_one')
        await firebase.assertSucceeds(testDoc.get());
    })

    it("Can't write an address if user is not owner", async () => {
        const db = getFirestore(theirAuth);
        const testDoc = db.collection('users').doc(myID).collection('addresses').doc('add_one')
        await firebase.assertFails(testDoc.set({foo: 'bar'}));
    })

    it("Can't read an address if user is not owner", async () => {
        const db = getFirestore(theirAuth);
        const testDoc = db.collection('users').doc(myID).collection('addresses').doc('add_one')
        await firebase.assertFails(testDoc.get());
    })

    it("Can write an address if user is owner", async () => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection('users').doc(myID).collection('addresses').doc('add_one')
        await firebase.assertSucceeds(testDoc.set({region: 'Nairobi', town: 'Westlands', address: 'Purshottam'}));
    })

    it("Can read an address if user is owner", async () => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection('users').doc(myID).collection('addresses').doc('add_one')
        await firebase.assertSucceeds(testDoc.get());
    })

    it("Can query rides if i am client", async () => {
        const db = getFirestore(myAuth)
        const testQuery = db.collection('rides').where('client','==',myID)
        await firebase.assertSucceeds(testQuery.get())
    })

    it("Can't query all rides", async () => {
        const db = getFirestore(myAuth)
        const testQuery = db.collection('rides')
        await firebase.assertFails(testQuery.get())
    })

    it("Can't create a ride document if client is not signed in user", async () => {
        const db = getFirestore(null)
        const testDoc = db.collection('rides').doc('ride_one');
        await firebase.assertFails(testDoc.set({client: null}))
    })

    it("Can create a ride document if client is signed in user", async () => {
        const db = getFirestore(myAuth)
        const testDoc = db.collection('rides').doc('ride_two');
        await firebase.assertSucceeds(testDoc.set({"client": myID}))
    })

    it("Can update a ride document if user is client", async () => {
        const admin = getAdminFirestore();
        const rideId = "ride_one";
        const setupDoc = admin.collection('rides').doc(rideId);
        await setupDoc.set({client: myID, rider: theirID})
        const db = getFirestore(myAuth)
        const testDoc = db.collection('rides').doc(rideId);
        await firebase.assertSucceeds(testDoc.update({status: true}))
    })

    it("Can update a ride document if user is rider", async () => {
        const admin = getAdminFirestore();
        const rideId = "ride_one";
        const setupDoc = admin.collection('rides').doc(rideId);
        await setupDoc.set({client: myID, rider: theirID})
        
        const db = getFirestore(theirAuth)
        const testDoc = db.collection('rides').doc("ride_one");
        await firebase.assertSucceeds(testDoc.update({status: false}))
    })

    it("Can allow a client to delete a ride if ride status is false", async () => {
        const db = getFirestore(myAuth)
        const testDoc = db.collection('rides').doc('ride_three')
        await testDoc.set({client: myID, ridestatus: false})
        await firebase.assertSucceeds(testDoc.delete())
    })

    it("Can't allow a client to delete a ride if ride status is true", async () => {
        const db = getFirestore(myAuth)
        const testDoc = db.collection('rides').doc('ride_three')
        await testDoc.set({client: myID, ridestatus: true})
        await firebase.assertFails(testDoc.delete())
    })

    it("Can't allow a rider to delete a ride", async () => {
        const db = getFirestore(theirAuth)
        const testDoc = db.collection('rides').doc('ride_one')
        await firebase.assertFails(testDoc.delete())
    })

    it("Can't allow unauthenticated users to view a product", async () => {
        const db = getFirestore(null)
        const productDoc = db.collectionGroup('products')
        await firebase.assertFails(productDoc.get())
    })

    it("Can allow authenticated users to view a product", async () => {
        const db = getFirestore(myAuth)
        const productQuery = db.collectionGroup('products')
        await firebase.assertSucceeds(productQuery.get())
    })

    it("Can't allow a client to write a product", async () => {
        const db = getFirestore(myAuth)
        const clientDoc = db.collection('users').doc(myID)
        await clientDoc.set({clientstatus: true})
        const productDoc = db.collection('users').doc(myID).collection('products').doc('product_one')
        await firebase.assertFails(productDoc.set({id: 'someId'}))
    })


    it("Can allow a supplier to create a valid product", async () => {
        const db = getFirestore(myAuth)
        const admin = getAdminFirestore()
        await admin.collection('users').doc(myID).set({clientStatus: false})
        const productDoc = db.collection('users').doc(myID).collection('products').doc('product_two')
        await firebase.assertSucceeds(productDoc.set({
            'price': 1,
            'quantity': 1,
            'category': 'bottled',
            'title': 'Dasani',
            'description': '500 Ml',
            'supplier': myID
        }))

    })

    it("Can only allow creation of only valid orders", async () => {
        const db = getFirestore(myAuth)
        const order = db.collection('orders').doc('order_one')

        const admin = getAdminFirestore()
        await admin.collection('users').doc(myID).set({clientStatus: true})

        await firebase.assertSucceeds({
            'client': myID,
            'status': false,
            'location': {latitude: 1, longitude: 2},
            'products': [1],
            'date': firebase.firestore.Timestamp.now()
        })
    })

    it ("Can't allow unauthorised users to view orders", async () => {
        const db = getFirestore(null)
        const order = db.collection('orders').doc('order_one')
        await firebase.assertFails(order.get())
    })

    it ("Can't only allow clients not associated with the order to view the order", async () => {
        const db = getFirestore(myAuth)
        const order = db.collection('orders').doc('order_one')

        const admin = getAdminFirestore()
        await admin.collection('orders').doc('order_two').set({client: 'sssf'})
        await firebase.assertFails(order.get())
    })

    it ("Can't only allow clients not associated with the order to view the order", async () => {
        const db = getFirestore(myAuth)
        const order = db.collection('orders').doc('order_one')

        const admin = getAdminFirestore()
        await admin.collection('orders').doc('order_two').set({supplier: 'ssdvdvsf'})
        await firebase.assertFails(order.get())
    })

    it ("Can only allow clients associated with the order to view the order", async () => {
        const db = getFirestore(myAuth)
        const order = db.collection('orders').doc('order_two')

        const admin = getAdminFirestore()
        await admin.collection('orders').doc('order_two').set({client: myID})
        await firebase.assertSucceeds(order.get())
    })

    it ("Can only allow suppliers associated with the order to view the order", async () => {
        const db = getFirestore(theirAuth)
        const order = db.collection('orders').doc('order_three')

        const admin = getAdminFirestore()
        await admin.collection('orders').doc('order_three').set({suppliers: [theirID]})
        await firebase.assertSucceeds(order.get())
    })

    it ("Can't allow unauthenticated users to read reviews", async () => {
        const db = getFirestore(null)
        const review = db.collection('reviews').doc('review_one')
        await firebase.assertFails(review.get())
    })

    it ("Can allow authenticated users to read reviews", async () => {
        const db = getFirestore(myAuth)
        const review = db.collection('reviews').doc('review_one')
        await firebase.assertSucceeds(review.get())
    })

    it ("Can't allow supplers to write reviews", async () => {
        const db = getFirestore(myAuth)
        const review = db.collection('reviews').doc('review_one')

        const admin = getAdminFirestore()
        await admin.collection('orders').doc('order_ten').set({
            supplier: myID,
            orderId: 'order_ten',
            status: 'completed',

        })
        await firebase.assertFails(review.set({
            orderId: 'order_ten',
            client: myID,
            title: 'sfsfsf',
            description: 'sfdfdfdfdfdfd'
        }))
    })

    it ("Can allow only valid reviews to be written", async () => {
        const db = getFirestore(myAuth)
        const review = db.collection('reviews').doc('review_one')

        const admin = getAdminFirestore()
        await admin.collection('orders').doc('order_ten').set({
            client: myID,
            orderId: 'order_ten',
            status: 'completed',

        })
        await firebase.assertSucceeds(review.set({
            orderId: 'order_ten',
            client: myID,
            title: 'sfsfsf',
            description: 'sfdfdfdfdfdfd'
        }))
    })

})

after(async () => {
    await firebase.clearFirestoreData({projectId: PROJECT_ID});
});