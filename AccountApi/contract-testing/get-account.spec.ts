import path = require("path");
import { Publisher } from "@pact-foundation/pact";
import { term } from "@pact-foundation/pact/src/dsl/matchers";
import { GetUser } from '../components/get-account/get-user';
import { User } from "../components/get-account/user";

jest.setTimeout(1000000);

import { pactWith } from 'jest-pact';


var opts = {
  pactFilesOrDirs: ["../pacts"],
  pactBroker: "http://ec2-3-8-160-74.eu-west-2.compute.amazonaws.com:9292/",
  consumerVersion: "1.0.0"
}
const publisher = new Publisher(opts);

pactWith({
  consumer: "account-api",
  provider: "user-api",
  port: 4311,
  // pactBrokerUrl: "http://ec2-3-8-160-74.eu-west-2.compute.amazonaws.com:9292/"
  log: path.resolve(process.cwd(), "../logs", "pact.log"),
  dir: path.resolve(process.cwd(), "../pacts"),
}, provider => {

  beforeAll(() => {
    process.env.BASE_URL = "http://localhost:4311";
  });

  afterAll(() => {
    publisher.publishPacts();
  })

  describe('User No Found ', () => {
    beforeAll(() => {
      provider.addInteraction({
        state: "User doesn't Exists",
        uponReceiving:
          "A non existing user id",
        withRequest: {
          path: term({
            generate: "/user/000000",
            matcher: "^/user/",
          }),
          method: "GET",
        },
        willRespondWith: {
          status: 404,
        },
      });
    })
    it("it will recive 404", async () => {
      try{
        await GetUser("0000000");
      }
      catch(error)
      {
        expect(error.response.status).toEqual(404);
      }
    });
  })

  describe('User Exist', () => {
    beforeAll(() =>
      provider.addInteraction({
        state: "User Exists",
        uponReceiving:
          "A user id",
        withRequest: {
          path: term({
            generate: "/user/123456",
            matcher: "^/user/",
          }),
          method: "GET",
        },
        willRespondWith: {
          body:
          // { //For json resposes we can use matches to do validation of the responses
          //   userId: string("123456"),
          //   firstName: string("Tony"),
          //   lastName: string("Stark"),
          //   email: email("tony.stark@avengers.com"),
          // },
          '{"userId":"123456","firstName":"Tony","lastName":"Stark","email":"tony.stark@avengers.com","test":"test"}',
          status: 200,
        },
      }));

    it("it will recive user", async () => {
      const expectedData: User = {
        userId: "123456",
        firstName: "Tony",
        lastName: "Stark",
        email: "tony.stark@avengers.com",
        test: "test"
      };
      const result = await GetUser("123456");
      expect(result.data).toEqual(expectedData);
      expect(result.status).toEqual(200);
    });
  })
});