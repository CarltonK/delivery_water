// import * as functions from 'firebase-functions'
import { Request, Response } from "express"
// import { lipaNaMpesa } from './payments/mpesa/stk_push'

// export const payAdminSecure = functions.firestore
//     .document('payments/Admin/remittances/{doc}')
//     .onCreate(async snapshot => {
//         try {
//             const model: PayAdminDocModel = snapshot.data() as PayAdminDocModel
//             const phone: number = Number("254" + model.phone.slice(1))
//             const amount = 10
//             await lipaNaMpesa(phone, amount)
//         } catch (error) {
//             console.error(error)
//         }
//     })

export function mpesaLnmCallbackForOrder(request: Request, response: Response) {
    try {
        console.log('---Received Safaricom M-PESA Webhook For New Order---')
        const serverRequest = request.body

        const code: number = serverRequest['Body']['stkCallback']['ResultCode']
        if (code === 0) {
            const transactionAmount: number = serverRequest['Body']['stkCallback']['CallbackMetadata']['Item'][0]['Value']
            const transactionCode: string = serverRequest['Body']['stkCallback']['CallbackMetadata']['Item'][1]['Value']
            const transactionPhone: number = serverRequest['Body']['stkCallback']['CallbackMetadata']['Item'][4]['Value']
            console.log(`${transactionAmount} KES was received from ${transactionPhone} under ${transactionCode}`)
        }
        //Send a Response back to Safaricom
        const message = {
            "ResponseCode": "00000000",
	        "ResponseDesc": "success"
        }
        response.json(message)
    } catch (error) {
        console.error(error)
    }
}