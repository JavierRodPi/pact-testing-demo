interface User {
  userId: string,
  firstName: string,
  lastName: string,
  email: string
}

//Replace by datasource
const users: User[]=[
  {
    userId: "123456",
    firstName: "Tony",
    lastName: "Stark",
    email: "tony.stark@avengers.com"
  },
  {
    userId: "67890",
    firstName: "Bruce",
    lastName: "Banner",
    email: "bruce.banner@avengers.com"
  },
  {
    userId: "987654",
    firstName: "Nick",
    lastName: "Fury",
    email: "nick.fury@avengers.com"
  },
]


export const handler = async (
  event: any
): Promise<any> => {

  if (!event.body) {
    return {
      statusCode: 400,
    } 
  }

  var userId = event.pathParameters.userId;

  var user = users.find(u => u.userId === userId);

  if (user){
    return {
      statusCode: 200,
      body: JSON.stringify(user)
    }
  }

  return {
    statusCode: 404,
    body: "User not found"
  }
}