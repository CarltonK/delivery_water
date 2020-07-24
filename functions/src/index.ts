import * as superadmin from 'firebase-admin'
superadmin.initializeApp()

// import * as api from './query_api'

import * as productOps from './product_operations'

export const db = superadmin.firestore()

exports.productIdentifier = productOps.identifyProduct

// /*
// !!!---API---!!!
// */
// exports.NaquaMain = api.NaquaMain