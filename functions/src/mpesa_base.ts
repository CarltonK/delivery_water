// import * as functions from 'firebase-functions'
import { Request, Response } from "express"

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