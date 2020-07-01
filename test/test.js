const assert = require('assert');
const firebase = require('@firebase/testing');

const PROJECT_ID = 'naqua-1b2bb';
const myID = "user_abc";
const theirID = "user_xyz";
const myAuth = {uid: myID, email: "abc@gmail.com"}
const theirAuth = {uid: theirID, email: "xyz@gmail.com"}

function getFirestore(auth) {
    return firebase.initializeTestApp({projectId: PROJECT_ID, auth: myAuth}).firestore();
}

function getAdminFirestore() {
    return firebase.initializeAdminApp({projectId: PROJECT_ID}).firestore();
}

before(async () => {
    await firebase.clearFirestoreData({projectId: PROJECT_ID});
});


describe('Naqua', () => {

    it("Can't write items in the read-only collection", async () => {
        const db = getFirestore(null);
        const testDoc = db.collection('private').doc('testDoc')
        await firebase.assertFails(testDoc.set({foo: "bar"}))
    })

    it('Can read items in the read-only collection', async () => {
        const db = getFirestore(null);
        const testDoc = db.collection('private').doc('testDoc')
        await firebase.assertSucceeds(testDoc.get())
    })

    it("Can't write a user document if user is not signed in", async () => {
        const db = firebase.initializeTestApp({projectId: PROJECT_ID}).firestore();
        const testDoc = db.collection('users').doc('user_abc');
        await firebase.assertFails(testDoc.set({foo: "bar"}))
    })

    it("Can't write a user document if user is not the owner", async () => {
        const auth = {uid: "user_abc", email: "abc@gmail.com"}
        const db = firebase.initializeTestApp({projectId: PROJECT_ID, auth: auth}).firestore();
        const testDoc = db.collection('users').doc(theirID);
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
        await setupDoc.set({client: myID, rideId: theirID})

        const db = getFirestore(myAuth)
        const testDoc = db.collection('rides').doc(rideId);
        await firebase.assertSucceeds(testDoc.update({status: true}))
    })

    it("Can update a ride document if user is rider", async () => {
        const db = getFirestore(theirAuth)
        const testDoc = db.collection('rides').doc("ride_two");
        await firebase.assertSucceeds(testDoc.update({status: false}))
    })

})

// after(async () => {
//     await firebase.clearFirestoreData({projectId: PROJECT_ID});
// });