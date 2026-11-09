import { BrowserRouter, Route, Routes } from 'react-router-dom';
import Layout from './components/Layout.jsx';
import Dashboard from './pages/Dashboard.jsx';
import Devices from './pages/Devices.jsx';
import Farms from './pages/Farms.jsx';
import Login from './pages/Login.jsx';
import Notifications from './pages/Notifications.jsx';
import Ponds from './pages/Ponds.jsx';
import RiskReports from './pages/RiskReports.jsx';
import Settings from './pages/Settings.jsx';

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route element={<Layout />}>
          <Route index element={<Dashboard />} />
          <Route path="farms" element={<Farms />} />
          <Route path="ponds" element={<Ponds />} />
          <Route path="devices" element={<Devices />} />
          <Route path="risk-reports" element={<RiskReports />} />
          <Route path="notifications" element={<Notifications />} />
          <Route path="settings" element={<Settings />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}
