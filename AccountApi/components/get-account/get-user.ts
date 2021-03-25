import axios from "axios";
import { User } from "./user";

export async function GetUser(userId: string){

  var baseUrl = process.env["BASE_URL"] as string;

  return await axios.get<User>(
    `${baseUrl}/user/${userId}`
  );
}