import * as superadmin from 'firebase-admin'
superadmin.initializeApp()

import * as productOps from './product_operations'

export const db = superadmin.firestore()

exports.productIdentifier = productOps.identifyProduct
