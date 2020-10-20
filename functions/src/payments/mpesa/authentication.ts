import axios from "axios";
import { routes } from '../../helpers/routes'
import { Buffer } from 'buffer'

const consumerKey: string | undefined = process.env.CONSUMER_KEY
const consumerSecret: string | undefined = process.env.CONSUMER_SECRET

export async function authenticate(): Promise<any> {

  try {
    const response = await axios({
      method: "GET",
      url: routes.production + routes.oauth,
      headers: {
        Authorization: "Basic " + Buffer.from(consumerKey + ":" + consumerSecret).toString("base64"),
      },
    })
    return response.data.access_token
  } catch (error) {
    console.error(error)
  }
}