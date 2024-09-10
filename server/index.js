const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const fs = require("fs");
const csv = require("csv-parser");

const app = express();
app.use(cors());
app.use(express.json())
app.use(bodyParser.json());

let organizations = [];
let accountPlans = [];

// Read data from the CSV when the server starts
fs.createReadStream("./data/organizations.csv")
  .pipe(csv())
  .on("data", (row) => {
    organizations.push({
      createdDate: row.createdDate,
      updatedDate: row.updatedDate,
      deletedAt: row.deletedAt,
      id: row.id,
      orgName: row.orgName,
      shopifyStoreId: row.__shopifyStoreId__,
      myShopifyDomain: row.myShopifyDomain,
      numBillingRetries: row.numBillingRetries,
      numFailedCyclesBeforeCancel: row.numFailedCyclesBeforeCancel,
      delayBetweenRetries: row.delayBetweenRetries,
      logo: row.logo,
      billingTime: row.billingTime,
      billingTimezone: row.billingTimezone,
      initialSubscriptionImportComplete:
        row.initialSubscriptionImportComplete === "TRUE", // Convert to boolean
      monthlyFee: parseFloat(row.monthly_fee),
      perTransactionFee: parseFloat(row.per_transaction_fee),
      perTransactionPercentageFee: parseFloat(
        row.per_transaction_percentage_fee
      ),
      billingStartDate: row.billing_start_date,
      account: JSON.parse(row.account), // Parse JSON
      alloyUserId: row.alloyUserId,
      activeWorkflows: JSON.parse(row.activeWorkflows), // Parse JSON
      setup: JSON.parse(row.setup), // Parse JSON,
      outOfStockBehavior: row.outOfStockBehavior,
      cancellationMessage: row.cancellationMessage,
      hasVisitedRetention: row.hasVisitedRetention === "TRUE", // Convert to boolean
      rewardsPointMeaningId: parseInt(row.rewardsPointMeaningId, 10),
      hasOtpEnabled: row.hasOtpEnabled === "TRUE", // Convert to boolean
      instagramUserData: JSON.parse(row.instagramUserData), // Parse JSON
      lookerDashboardPrefix: row.lookerDashboardPrefix,
    });
  })
  .on("end", () => {
    console.log("Organizations CSV file successfully processed");
  });

fs.createReadStream("./data/account_plans.csv")
  .pipe(csv())
  .on("data", (row) => {
    accountPlans.push({
      createdDate: row.createdDate,
      planName: row.planName,
      organizationId: row.organizationId,
      status: row.status,
    });
  })
  .on("end", () => {
    console.log("Account Plan CSV file successfully processed");
  });

// Endpoint to get optimization settings by myShopifyDomain
app.get("/optimization/:domain", (req, res) => {
  const { domain } = req.params;
  const organization = organizations.find(
    (org) => org.myShopifyDomain === domain
  );

  if (organization) {
    res.json({
      optimization: organization.setup.optimization,
    });
  } else {
    res.status(404).json({ error: "Organization not found" });
  }
});

// Endpoint to get all organizations sorted by creation date
app.get("/organizations", (req, res) => {
  const sortedOrganizations = accountPlans
    .slice()
    .sort((a, b) => new Date(a.createdDate) - new Date(b.createdDate))
    .map((org) => ({
      orgName: org.organizationId,
      createdDate: org.createdDate,
      status: org.status,
      planName: org.planName,
    }));
  res.json(sortedOrganizations);
});

// Endpoint to get cancelled organizations
app.get("/organizations/cancelled", (req, res) => {
  const cancelledOrgs = accountPlans.filter(
    (org) => org.status === "CANCELLED"
  );
  res.json(cancelledOrgs);
});

// Endpoint to get organization by orgName
app.get("/organization/:name", (req, res) => {
  const { name } = req.params;
  const organization = organizations.find(
    (org) => org.orgName.toLowerCase() === name.toLowerCase()
  );

  if (organization) {
    res.json(organization);
  } else {
    res.status(404).json({ error: "Organization not found" });
  }
});

// Start the server
const PORT = 3001;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
