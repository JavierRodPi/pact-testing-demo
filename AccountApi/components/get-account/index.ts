import { GetUser } from "./get-user";

export const handler = async (
  event: any
): Promise<any> => {
  const result = GetUser(event.pathParameters.userId)
  //Validations and other data request....
  return {
    statusCode: 200,
    body: JSON.stringify(result)
  }
}