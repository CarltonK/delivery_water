import { routes } from '../../helpers/routes'
import { authenticate } from './authentication'
import axios from 'axios'

const passKey: any = process.env.PASS_KEY
const shortCode: any = process.env.SHORT_CODE
const merchantCode: any = process.env.MERCHANT_CODE

export async function lipaNaMpesa(phone: number, amount: number) {
    const timestamp = new Date().toISOString().replace(/[^0-9]/g, "").slice(0, -3)
    const password = Buffer.from(shortCode + passKey + timestamp).toString("base64")

    try {
        const token = await authenticate()
        await axios({
            method: "POST",
            url: routes.production + routes.stkpush,
            headers: {
              Authorization: "Bearer " + token,
            },
            data: {
                BusinessShortCode: shortCode,
                Password: password,
                Timestamp: timestamp,
                // CustomerPayBillOnline
                // CustomerBuyGoodsOnline
                TransactionType: "CustomerBuyGoodsOnline",
                Amount: amount,
                PartyA: phone,
                PartyB: merchantCode,
                PhoneNumber: phone,
                CallBackURL: "https://europe-west3-naqua-1b2bb.cloudfunctions.net/mpesaMain/api/v1/nitumiekakitu/q0WnbvFGLsvMFbfEDW25",
                AccountReference: phone,
                TransactionDesc: "New Order"
            }
        })
    } catch (error) {
        console.error(error)
    }
}