"use client";

import { useEffect, useState } from "react";

export default function ListOrgs() {
  const [organizations, setOrganizations] = useState([]);
  const backendUrl = "http://localhost:3001";

  useEffect(() => {
    const fetchOrganizations = async () => {
      const url = `${backendUrl}/organizations`;
      const response = await fetch(url);

      if (response.ok) {
        const data = await response.json();
        setOrganizations(data);
      }
    };
    fetchOrganizations();
  }, []);

  return (
    <div className="mt-5 mb-5">
      <h3 className="block mb-2 text-grape text-xl font-semibold">
        List of Organizations
      </h3>
      {organizations && (
        <table className="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400 border">
          <thead className="text-sm text-gray-700 uppercase">
            <tr>
              <th scope="col" className="px-6 py-3">
                Organization Name
              </th>
              <th scope="col" className="px-6 py-3">
                Created At
              </th>
              <th scope="col" className="px-6 py-3">
                Status
              </th>
              <th scope="col" className="px-6 py-3">
                Plan
              </th>
            </tr>
          </thead>
          <tbody>
            {organizations.map((org, index) => (
              <tr key={index} className="odd:bg-white even:bg-gray-50">
                <td className="px-6 py-4">{org.orgName}</td>
                <td className="px-6 py-4">
                  {new Date(org.createdDate).toLocaleDateString("en-GB")}
                </td>
                <td className="px-6 py-4">{org.status}</td>
                <td className="px-6 py-4">{org.planName}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}
