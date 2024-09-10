import "./globals.css";

export const metadata = {
  title: "Organization Reports",
  description: "Smartrr Organizations",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en" className="bg-light_purple">
      <body className="container mx-auto">{children}</body>
    </html>
  );
}
