import * as superadmin from 'firebase-admin'
superadmin.initializeApp()

import * as productOps from './product_operations'
import * as orderOps from './order_operations'

export const db = superadmin.firestore()
export const ff = superadmin.firestore;

exports.productIdentifier = productOps.identifyProduct

exports.newOrder = orderOps.newOrder

