"use client";

import { useEffect, useState } from "react";

export default function CancelledOrgs() {
  const [cancelled, setCancelled] = useState([]);
  const backendUrl = "http://localhost:3001";

  useEffect(() => {
    const fetchCancelled = async () => {
      const url = `${backendUrl}/organizations/cancelled`;
      const response = await fetch(url);

      if (response.ok) {
        const data = await response.json();
        setCancelled(data);
      }
    };
    fetchCancelled();
  }, []);

  return (
    <div className="mt-5 mb-5">
      <h3 className="block mb-2 text-grape text-xl font-semibold">
        Cancelled Organizations
      </h3>
      <ul>
        {cancelled && (
          <table className="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400 border">
            <thead className="text-sm text-gray-700 uppercase">
              <tr>
                <th scope="col" className="px-6 py-3">
                  Organization Name
                </th>
                <th scope="col" className="px-6 py-3">
                  Status
                </th>
              </tr>
            </thead>
            <tbody>
              {cancelled.map((org, index) => (
                <tr key={index} className="odd:bg-white even:bg-gray-50">
                  <td className="px-6 py-4">{org.organizationId}</td>
                  <td className="px-6 py-4">{org.status}</td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </ul>
    </div>
  );
}
