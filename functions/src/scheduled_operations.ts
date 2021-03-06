import * as functions from 'firebase-functions'
// import { db } from './index'

// Every day at 1800 HRS
// ("0 18 * * *")

export const dailySupplierPayment = functions.runWith({
    memory: '512MB',
    timeoutSeconds: 30,
}).region('europe-west3').pubsub.schedule('0 18 * * *')
    .timeZone('Africa/Nairobi')
    .onRun(async (context: functions.EventContext) => {
        console.log('This will be used to pay suppliers')
});