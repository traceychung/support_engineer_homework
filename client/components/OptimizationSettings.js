"use client";

import { useState } from "react";

export default function OptimizationSettings() {
  const [myShopifyDomain, setMyShopifyDomain] = useState("");
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);
  const backendUrl = process.env.NEXT_PUBLIC_BACKEND_URL;

  const handleFetchOptimizationSettings = async () => {
    try {
      const response = await fetch(
        `${backendUrl}/optimization/${myShopifyDomain}`
      );
      if (!response.ok) {
        throw new Error("Organization not found");
      }
      const result = await response.json();
      setData(result.optimization);
      setError(null);
    } catch (err) {
      setData(null);
      setError(err.message);
    }
  };

  return (
    <div className="mt-5 mb-5">
      <label className="block mb-2 text-grape text-xl font-semibold">
        Optimization Settings
      </label>
      <div className="flex">
        <input
          type="text"
          className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
          value={myShopifyDomain}
          onChange={(e) => setMyShopifyDomain(e.target.value)}
          placeholder="Enter Shopify Domain e.g. test-account-1.myshopify.com"
        />
        <button
          onClick={handleFetchOptimizationSettings}
          className="text-grape bg-lime_green hover:bg-grape hover:text-white font-sm font-semibold rounded-lg text-sm text-center ml-2 me-2">
          Get Optimization Settings
        </button>
      </div>

      {data && (
        <div className="mt-2">
          <pre>{JSON.stringify(data, null, 2)}</pre>
        </div>
      )}

      {error && (
        <div
          className="mt-2 bg-red-100 border border-red text-red px-4 py-3 rounded relative">
            {error}
        </div>
      )}
    </div>
  );
}
