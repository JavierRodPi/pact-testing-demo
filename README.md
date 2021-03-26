
<p align="center">
  <h1 align="center">Contract testing for AWS Microservices with PACT and localstack</h1>
</p>

<br />
<br />

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#prerequisites">Prerequisites</a></li>
    <li><a href="#installation">Installation</a></li>
    <li><a href="#consumer-testing">Consumer Testing</a></li>
    <li><a href="#provider-testing">Provider Testing</a></li>
    <li><a href="#installation-issues">Pact package installation issues</a></li>
    <li><a href="#links">Links</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This project is a demo that will allow you to understand and learn how to do contract testing in an AWS Serverless microservice (AWS API Gateway and AWS Lambda) without needing to deploy any service to a real AWS environment.

This demo uses the next components:
* **PACT** For running the tests
* **PACT Broker** For sharing the contracts
* **Localstack** to run a local AWS environment
* **Terraform** for deploying the provider 

The demo is composed of two microservices Account API (Consumer) and User API (Provider). 

![image](https://user-images.githubusercontent.com/17270660/112550503-618b9000-8db7-11eb-96fa-40445f590888.png)


## Prerequisites

To run this demo you are going to need the next installed in your machine:

**Docker**: https://docs.docker.com/get-docker/

**Terraform**: https://learn.hashicorp.com/tutorials/terraform/install-cli

**Node JS**: https://nodejs.org/en/download/

**Pact broker**:

Pact Broker requires a Postgres db to work, so the first step is to install and configure one,

Postgre db
 ```sh
 docker run --name pactbroker-db -e POSTGRES_PASSWORD=ThePostgresPassword -e POSTGRES_USER=admin -e PGDATA=/var/lib/postgresql/data/pgdata -v /var/lib/postgresql/data:/var/lib/postgresql/data -d postgres
```

    docker run -it --link pactbroker-db:postgres --rmGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U admin'
  Login with you password and run the next commands individually:
 
   

    CREATE USER pactbrokeruser WITH PASSWORD 'TheUserPassword';
    CREATE DATABASE pactbroker WITH OWNER pactbrokeruser;
    GRANT ALL PRIVILEGES ON DATABASE pactbroker TO pactbrokeruser;
    exit

Pact Brocker

    docker run --name pactbroker --link pactbroker-dbERNAME=pactbrokeruser -e PACT_BROKER_DATABASE_PASSWORD=TheUserPassword -e PACT_B_BROKER_DATABASE_NAME=pactbroker -d  -p 9292:9292 pactfoundation/pact-broker


## Installation

 1. Clone the repo
   ```sh
   https://github.com/JavierRodPi/pact-testing-demo.git
   ```
 2. Navigate to the root folder of the project and run localstack from the docker-compose file.
   ```sh
   docker-compose -f docker-localstack.yml up -d
   ```
  
<!-- CONSUMER TESTING -->
## Consumer (Account API)

You will find the consumer test under 

    ~/AccountApi/contract-testing/get-user.spec.ts

To run this test first, you will need to install all the dependencies. 

 1. From the project root folder `cd AccountApi/contract-testing`
 2. `yarn install`
		If you are facing issues with the installation of PACT, please review this   <a href="#installation-issues">Section</a>
		
 3.  Once all the dependencies are installed you will need to configure your PACT Broker path.
Inside the "get-user.spec.ts" file modify

    pactBroker:  "YOUR_BROKER_URL",

 4. Run the test `jest`

  
The test will generate the pact file and it will upload the pact to the broker.

<!-- PROVIDER TESTING -->
## Provider Testing (User API)

You will find the provider under 

    ~/UserApi/components/get-account

In order to run this test first you will need to build and upload get-user to localstack:

 1.  From the project root folder `cd UserApi/components/get-user` 
 2. `yarn install / npm install`
 3. `tsc`
 4. Copy node_modules folder into dist
 5. Zip all the content inside dist and name the file "get-user.zip"
 6. `cd dist`
 7. `aws  --endpoint-url=http://localhost:4566 s3 mb s3://artifacts`
 8. `aws  --endpoint-url=http://localhost:4566 s3 cp ./get-user.zip s3://artifacts`

After building and uploading the get-user artefact into S3 you will need to create the environment inside localstack.

 1. From the project root folder `cd UserApi/iac/env/local`
 2. `terraform init`
 3. `terraform plan`
 4. `terraform apply -auto-approve`

Now that the local environment is live you will be able to continue with the provider test

Install test dependencies and run the provider test
 1. From the project root folder `cd UserApi/contract-testing`
 2. `yarn install`
		If you are facing issues with the installation of PACT, please review this   <a href="#installation-issues">Section</a>
		
 3.  Once all the dependencies are installed you will need to configure your PACT Broker path.
Inside the "get-user.spec.ts" file modify:     `pactUrls:  "YOUR_BROKER_URL",`  

 4. Run the test `jest`

  
<!-- INSTALLATION ISSUES-->
## Pact package installation issues

Installation workaround:
Source: https://github.com/pact-foundation/pact-js-core 

### Pact Download Location

For those that are behind a corporate firewall or are seeing issues where our package downloads binaries during installation, you can download the binaries directly from our  [github releases](https://github.com/pact-foundation/pact-ruby-standalone/releases), and specify the location where you want Pact to get the binaries from using the 'config' section in your package.json file:

    {
    	"name": "some-project",
    	...
    	"config": {
    		"pact_binary_location": "/home/some-user/Downloads"
    	},
    	...
    }

It will accept both a local path or an http(s) url. It must point to the directory containing the binary needed as the binary name is appended to the end of the location. For the example given above, Pact will look for the binary at  `/home/some-user/Downloads/pact-1.44.0-win32.zip`  for a Windows system. However, by using this method, you must use the correct Pact version binary associated with this version of Pact-Core. For extra security measurements, checksum validation has been added to prevent tampering with the binaries.

If your environment uses self-signed certificates from an internal Certificate Authority (CA), you can configure this using the standard options in an  [npmrc](https://docs.npmjs.com/configuring-npm/npmrc.html)  file as per below:

    _~/.npmrc_:
    
    cafile=/etc/ssl/certs/ca-certificates.crt
    strict-ssl=true


### Skip Pact binary downloading

You can also force Pact to skip the installation of the binary during  `npm install`  by setting  `PACT_SKIP_BINARY_INSTALL=true`. This feature is useful if you want to speed up builds that don't need Pact and don't want to modify your projects dependencies.

Note that pact-core will not be functional without the binary.

    PACT_SKIP_BINARY_INSTALL=true npm install


<!-- LINKS -->
## Links
**Tools**
 * [PACT](https://docs.pact.io/)
 * [PACT JS](https://github.com/pact-foundation/pact-js-core)
 * [PACT Git hub](https://www.npmjs.com/package/@pact-foundation/pact)
 * [Localstack](https://localstack.cloud/)


**Contracts testing**

 * https://martinfowler.com/bliki/ContractTest.html
 * https://martinfowler.com/articles/consumerDrivenContracts.html#Consumer-drivenContracts
 * https://blog.scottlogic.com/2019/01/07/introduction-to-contract-testing-part-1.html
 * https://pactflow.io/blog/what-is-contract-testing/

## Contact

 - Twitter	[@javierrodpi](https://twitter.com/javierrodpi) 
 - Linkedin	[@jrptech](https://www.linkedin.com/in/jrptech) 
 - Email	javierrp@outlook.com
