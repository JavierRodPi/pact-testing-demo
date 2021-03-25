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
      pactUrls: ["YOUR_BROKER_URL"],
      timeout: 1000000,
    };
    return await new Verifier(verifierOptions).verifyProvider();
  });
});
