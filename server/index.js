const express = require("express");
require("dotenv").config();
const cors = require("cors");
const bodyParser = require("body-parser");
const fs = require("fs");
const csv = require("csv-parser");
const moment = require("moment");

const app = express();
app.use(cors());
app.use(express.json())
app.use(bodyParser.json());

let organizations = [];
let accountPlans = [];
let organizationsMap = {};

// Function to determine and convert the data type of a value
function parseValue(value) {
  // Check if the value is a nested object (e.g., JSON string)
  try {
    // Try to parse the value as JSON if it looks like a JSON object
    if (value.startsWith("{") || value.startsWith("[")) {
      const parsed = JSON.parse(value);
      if (typeof parsed === "object") {
        return parsed;
      }
    }
  } catch (e) {
    // If JSON parsing fails, continue with other types
    console.error("Error parsing JSON: ", e);
  }
  // Convert to number if possible
  if (!isNaN(value) && value !== "") {
    return parseFloat(value);
  }
  // Convert to boolean if it matches true/false
  if (value.toLowerCase() === "true") {
    return true;
  }
  if (value.toLowerCase() === "false") {
    return false;
  }
  if (value === "NULL") {
    return null;
  }
  // Attempt to parse date (ISO format or other recognizable formats)
  if (moment(value, "YYYY-MM-DD H:mm:ss", true).isValid()) {
      const date = new Date(value);
      return date;
  }
  // Default case: return the value as a string
  return value;
}

// Read data from the CSV when the server starts
let orgIndex = 0
fs.createReadStream("./data/organizations.csv")
  .pipe(csv())
  .on("data", (row) => {
    let obj = {};
    for (const key in row) {
      obj[key] = parseValue(row[key]);
    }
    organizationsMap[row.id] = orgIndex;
    orgIndex++;
    organizations.push(obj);
  })
  .on("end", () => {
    console.log("Organizations CSV file successfully processed");
  });

fs.createReadStream("./data/account_plans.csv")
  .pipe(csv())
  .on("data", (row) => {
    let obj = {};
    for (const key in row) {
      obj[key] = parseValue(row[key]);
    }
    accountPlans.push(obj);
  })
  .on("end", () => {
    console.log("Account Plans CSV file successfully processed");
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
    res.status(404).json({ error: "Organization not found"});
  }
});

// Endpoint to get all organizations sorted by creation date
app.get("/organizations", (req, res) => {
  const sortedOrganizations = accountPlans
    .slice()
    .sort((a, b) => new Date(a.createdDate) - new Date(b.createdDate))
    .map((org) => ({
      orgName: organizations[organizationsMap[org.organizationId]].orgName,
      createdDate: org.createdDate,
      status: org.status,
      planName: org.planName,
    }));
  res.json(sortedOrganizations);
});

// Endpoint to get cancelled organizations
app.get("/organizations/cancelled", (req, res) => {
  const cancelledOrgs = accountPlans
    .filter((org) => org.status === "CANCELLED")
    .map((org) => ({
      orgName: organizations[organizationsMap[org.organizationId]].orgName,
      status: org.status,
    }));
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
const PORT = process.env.BACKEND_PORT;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
