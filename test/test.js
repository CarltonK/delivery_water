const assert = require('assert');
const firebase = require('@firebase/testing');

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

before(async () => {
    await firebase.clearFirestoreData({projectId: PROJECT_ID});
});


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

    it("Can write a user document if user is signed in and is owner", async () => {
        const db = getFirestore(myAuth)
        const testDoc = db.collection('users').doc(myID);
        await firebase.assertSucceeds(testDoc.set({foo: "bar"}))
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

    it("Can't allow a client to write a product", async () => {
        const db = getFirestore(myAuth)
        const clientDoc = db.collection('users').doc(myID)
        await clientDoc.set({clientstatus: true})
        const productDoc = db.collection('users').doc(myID).collection('products').doc('product_one')
        await firebase.assertFails(productDoc.set({id: 'someId'}))
    })


    it("Can allow a supplier to write a product", async () => {
        const db = getFirestore(myAuth)
        const clientDoc = db.collection('users').doc(myID)
        await clientDoc.set({clientstatus: false})
        const productDoc = db.collection('users').doc(myID).collection('products').doc('product_one')
        await firebase.assertSucceeds(productDoc.set({id: 'someId'}))
    })

})

after(async () => {
    await firebase.clearFirestoreData({projectId: PROJECT_ID});
});