import { Verifier, VerifierOptions } from "@pact-foundation/pact";
import AWS from "aws-sdk";


jest.setTimeout(1000000);

describe("Pact Verification", () => {
  it("validates", async () => {
    const aouGateway = new AWS.APIGateway({
      endpoint: "http://localhost:4566/",
      region: "us-east-1",
    });
    const result = await aouGateway.getRestApis().promise();
    let localApiId = "";
    if (result && result.items && result.items[0] && result.items[0].id) {
      localApiId = result.items[0].id;
    }
    const verifierOptions: VerifierOptions = {
      providerBaseUrl: `http://localhost:4566/restapis/${localApiId}/api/_user_request_/`,
      pactUrls: ["http://ec2-3-8-160-74.eu-west-2.compute.amazonaws.com:9292/pacts/provider/user-api/consumer/account-api/latest"
      ],
      timeout: 1000000,
    };
    return await new Verifier(verifierOptions).verifyProvider();
  });
});
