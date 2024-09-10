import OptimizationSettings from "../components/OptimizationSettings";
import ListOrgs from "../components/ListOrgs";
import CancelledOrgs from "../components/CancelledOrgs";
import OrgRecord from "../components/OrgRecord";

function Header({ title }) {
  return (
    <h1 className="mt-2 text-3xl font-bold text-center text-grape">{title}</h1>
  );
}

export default function HomePage() {
  return (
    <div>
      <Header title="Organization Reports" />
      <OptimizationSettings />
      <ListOrgs />
      <CancelledOrgs />
      <OrgRecord />
    </div>
  );
}
