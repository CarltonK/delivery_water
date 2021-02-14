import * as functions from 'firebase-functions'
// import { db } from './index'

export const dailySupplierPayment = functions.runWith({
    memory: '512MB',
    timeoutSeconds: 30,
}).region('europe-west3').pubsub.schedule(`every 1 min`)
    .timeZone('Africa/Nairobi')
    .onRun(async (context: functions.EventContext) => {
        console.log('This will be used to pay suppliers')
});