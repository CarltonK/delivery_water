import * as superadmin from 'firebase-admin'
superadmin.initializeApp()

import * as productOps from './product_operations'
import * as orderOps from './order_operations'
import * as functions from 'firebase-functions'
import * as express from 'express'
import * as mpesa from './mpesa_base'

export const db = superadmin.firestore()
export const ff = superadmin.firestore;

// Define functions
const regionalFunctions = functions.runWith({ 
    memory: '512MB', 
    timeoutSeconds: 30,
}).region('europe-west3')


// New Product
exports.productIdentifier = productOps.identifyProduct

// New Order
exports.newOrder = orderOps.newOrder

// Initialize Express Server
const app = express()
const main = express()

// /*
// SERVER CONFIGURATION
// 1) Base Path
// 2) Set JSON as main parser
// */
main.use('/api/v1', app)
main.use(express.json())

export const mpesaMain = regionalFunctions.https.onRequest(main)

// M-PESA Endpoints
// 1) Lipa Na Mpesa Online Callback URL
app.post('/nitumiekakitu/q0WnbvFGLsvMFbfEDW25', mpesa.mpesaLnmCallbackForOrder)
