"use client";

import { useState } from "react";

export default function OrgRecord() {
  const [orgName, setOrgName] = useState("");
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);
  const backendUrl = "http://localhost:3001";

  const handleFetchOrgRecord = async () => {
    try {
      const response = await fetch(`${backendUrl}/organization/${orgName}`);
      if (!response.ok) {
        throw new Error("Organization not found");
      }
      const result = await response.json();
      setData(result);
      setError(null);
    } catch (err) {
      setData(null);
      setError(err.message);
    }
  };

  return (
    <div className="mt-5 mb-5">
      <label className="block mb-2 text-grape  text-xl font-semibold">
        Organization Record
      </label>
      <div className="flex">
        <input
          type="text"
          className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
          value={orgName}
          onChange={(e) => setOrgName(e.target.value)}
          placeholder="Enter Organization Name e.g. Test Account 1"
        />
        <button
          className="text-grape bg-lime_green hover:bg-grape hover:text-white font-sm font-bold rounded-lg text-sm text-center ml-2 me-2"
          onClick={handleFetchOrgRecord}>
          Get Organization Record
        </button>
      </div>

      {data && (
        <div>
          <pre>{JSON.stringify(data, null, 2)}</pre>
        </div>
      )}

      {error && (
        <div>
          <h3>{error}</h3>
        </div>
      )}
    </div>
  );
}
