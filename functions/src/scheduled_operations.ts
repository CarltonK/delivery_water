import * as functions from 'firebase-functions'
// import { db } from './index'

export const dailySupplierPayment = functions.runWith({
    memory: '512MB',
    timeoutSeconds: 30,
}).region('europe-west1').pubsub.schedule(`every 5 min`)
    .timeZone('Africa/Nairobi')
    .onRun(async (context: functions.EventContext) => {
        
});