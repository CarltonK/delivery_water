import * as superadmin from 'firebase-admin'

const fcm = superadmin.messaging()

export async function singleNotificationSend(token: string, message: string, title: string): Promise<void> {
    try {
        if (token !== null) {
            const payload = {
                notification: {
                    title: title,
                    body: message,
                    clickAction: 'FLUTTER_NOTIFICATION_CLICK'
                }
            }
            await fcm.sendToDevice(token, payload)
        }
    } catch (error) {
        console.error('singleNotificationSendERROR: ',error)
    }
}