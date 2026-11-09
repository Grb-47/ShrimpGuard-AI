import { NavLink, Outlet } from 'react-router-dom';

const links = [
  { to: '/', label: 'Dashboard', end: true },
  { to: '/farms', label: 'Farms' },
  { to: '/ponds', label: 'Ponds' },
  { to: '/devices', label: 'Devices' },
  { to: '/risk-reports', label: 'Risk Reports' },
  { to: '/notifications', label: 'Notifications' },
  { to: '/settings', label: 'Settings' },
];

export default function Layout() {
  return (
    <div className="app-shell">
      <aside className="sidebar">
        <div className="brand">
          <span className="brand-mark">SG</span>
          <div>
            <strong>ShrimpGuard AI</strong>
            <small>CSE4104-7C-T04</small>
          </div>
        </div>

        <nav className="nav">
          {links.map((link) => (
            <NavLink
              key={link.to}
              to={link.to}
              end={link.end}
              className={({ isActive }) => (isActive ? 'nav-link active' : 'nav-link')}
            >
              {link.label}
            </NavLink>
          ))}
        </nav>

        <div className="sidebar-note">
          Week 02 foundation. Data screens are placeholders.
        </div>
      </aside>

      <main className="main">
        <header className="topbar">
          <div>
            <h1>Water Quality Monitoring</h1>
            <p>AI-assisted environmental risk dashboard</p>
          </div>
          <NavLink to="/login" className="button ghost">
            Sign in
          </NavLink>
        </header>

        <section className="content">
          <Outlet />
        </section>
      </main>
    </div>
  );
}
