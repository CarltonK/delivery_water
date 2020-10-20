export interface StkPushModel {
    BusinessShortCode: number
    Amount: number
    PartyA: string
    PartyB: string
    PhoneNumber: string
    CallBackURL: string
    AccountReference: string
    passKey: any
    TransactionType?: "CustomerPayBillOnline"
    TransactionDesc?: string
}