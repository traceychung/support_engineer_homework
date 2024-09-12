# Organization Reports Application
This project is a web-based application that provides insights into organizational data. It uses Express for the backend, Next.js for the frontend, and TailwindCSS for styling. Users can view various reports related to organizations, including their optimization settings, a list of organizations, cancelled organizations, and detailed information by organization name.

# Features
- Optimizations Settings
    - Takes the value of a `myShopifyDomain` field as an input and returns their `optimization` settings
- List of Organizations
   -  Loops through all organizations and shows the date they were created (DD/MM/YYYY), their `status`, and `planName` sorted by oldest to newest
- List of Cancelled Organizations
  - Returns the list of organizations whose status is cancelled
- Organization Record by Organization Name
  - Takes the value of an `orgName` and returns the organization record in JSON format

# Getting Started
## Prerequisites
To run this project, ensure you have the following installed on your machine:
- Node.js
- npm

## Installation
1. Clone the repository
  ```
  git clone https://github.com/traceychung/support_engineer_homework.git
  ```
2. Navigate to the project folder
  ```
  cd support_engineer_homework
  ```
3. Set up environment variables
    - Create a `.env` file in the `server` folder with the variable `BACKEND_PORT` (e.g., `BACKEND_PORT=3001`).
    - Create a `.env.local` file in the `client` folder with the variable `NEXT_PUBLIC_BACKEND_URL` (e.g., `NEXT_PUBLIC_BACKEND_URL=http://localhost:3001`).

## Running the Server
1. Open a new terminal window
2. Navigate to the `server` folder
  ```
  cd server
  ```
3. Install dependencies
  ```
  npm install
  ```
4. Start the server
  ```
  node index.js
  ```

## Running the Client
1. Open a new terminal window
2. Navigate to the `client` folder
  ```
  cd client
  ```
3. Install dependencies
  ```
  npm install
  ```
4. Start the client
  ```
  npm run dev
  ```
5. Launch the web app by navigating to `http://localhost:3000`

# Directory Structure
```bash
.
├── README.md
├── client
│   ├── app
│   │   ├── globals.css
│   │   ├── layout.js
│   │   └── page.js
│   ├── components
│   │   ├── CancelledOrgs.js
│   │   ├── ListOrgs.js
│   │   ├── OptimizationSettings.js
│   │   └── OrgRecord.js
│   ├── package-lock.json
│   ├── package.json
│   ├── postcss.config.js
│   └── tailwind.config.js
└── server
    ├── data
    │   ├── account_plans.csv
    │   └── organizations.csv
    ├── index.js
    ├── package-lock.json
    ├── package.json
    └── sql
        └── sql_queries.sql
```

# API Endpoints
## Base URL
`http://localhost:3001`

## Endpoints
1. *Get Optimization Settings*
- Endpoint: `/optimization/:domain`
- Method: `GET`
- Description: Retrieve optimization settings for a specific organization by its myShopifyDomain
- URL Parameters:
  - `domain` (string): The Shopify domain of the organization
- Request Example:
  ```
  GET /optimization/test-account-1.myshopify.com
  ```
- Response:
  - Status Code: `200 OK`
  - Body:
    ```
    {
      "optimization": {
        "shipping": true,
        "theming": false,
        "transaction": true,
        "integrations": true
      }
    }
    ```

2. *Get All Organizations*
- Endpoint: `/organizations`
- Method: `GET`
- Description: Retrieve a list of all organizations sorted by creation date
- Request Example:
  ```
  GET /organizations
  ```
- Response:
  - Status Code: `200 OK`
  - Body:
    ```
    [
      {
        "orgName": "Test Account 1",
        "createdDate": "2023-01-20T04:07:20Z",
        "status": "ACTIVE",
        "planName": "Basic Plan"
      },
      ...
    ]
    ```

3. *Get Cancelled Organizations*
- Endpoint: `/organizations/cancelled`
- Method: `GET`
- Description: Retrieve a list of organizations that have been cancelled
- Request Example:
  ```
  GET /organizations/cancelled
  ```
- Response:
  - Status Code: `200 OK`
  - Body:
    ```
    [
      {
        "createdDate": "2023-01-20T00:44:55Z",
        "planName": "Premium Plan",
        "orgName": "Test Account 5",
        "status": "CANCELLED"
      },
      ...
    ]
    ```

4. *Get Organization by Name*
- Endpoint: `/organization/:name`
- Method: `GET`
- Description: Retrieve detailed information for a specific organization by its name
- URL Parameters:
  - `name` (string): The name of the organization
- Request Example:
  ```
  GET /organizations/Test%20Account%201
  ```
- Response:
  - Status Code: `200 OK`
  - Body:
    ```
    {
      "id": "cce0223a-fcac-4953-9137-3c5c10c158c3",
      "orgName": "Test Account 1",
      "myShopifyDomain": "test-account-1.myshopify.com",
      ...
    }
    ```

# SQL Queries
The SQL queries for the following tasks can be found at `./server/sql/sql_queries.sql`.

## Queries Provided
- How many organizations do not have account plans?
- How many organizations have more than one account plan?
- List all organizations that have only one account plan.
- List all organizations that have the PASSWORDLESS feature set to true.

## How to Execute the SQL Queries
1. *Set Up the Database*:
  - Use an online SQL Editor like [NextLeap](https://nextleap.app/online-compiler/sql-programming) or any SQL client of your choice
  - Copy and paste the `init-db.sql` file into your SQL Editor to create the necessary tables and insert the corresponding data
2. *Run the Queries*:
  -  Copy and paste each query from `./server/sql/sql_queries.sql` into the SQL Editor to execute them
