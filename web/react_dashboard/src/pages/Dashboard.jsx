import StatCard from '../components/StatCard.jsx';

export default function Dashboard() {
  return (
    <>
      <div className="stat-grid">
        <StatCard label="Farms" value="—" hint="API not connected" />
        <StatCard label="Ponds" value="—" hint="API not connected" />
        <StatCard label="Devices online" value="—" hint="API not connected" />
        <StatCard label="Open risk reports" value="—" hint="API not connected" />
      </div>

      <div className="panel">
        <h2>Monitoring overview</h2>
        <p className="muted">
          ShrimpGuard AI collects pH, dissolved oxygen, temperature, salinity,
          and manual ammonia readings. A separate Python service classifies
          environmental risk; Gemini explains validated results in Bengali.
        </p>

        <div className="split">
          <div>
            <h3>Data path</h3>
            <ol className="flow">
              <li>Sensors → ESP32</li>
              <li>ESP32 → Flutter app over Bluetooth</li>
              <li>Flutter app → Node.js API</li>
              <li>Node.js → PostgreSQL + Python risk service</li>
              <li>Risk report → Bengali explanation</li>
            </ol>
          </div>
          <div>
            <h3>Foundation status</h3>
            <ul className="checklist">
              <li>Database schema designed</li>
              <li>Service skeletons created</li>
              <li>Hardware documentation drafted</li>
              <li>Live data integration pending</li>
            </ul>
          </div>
        </div>
      </div>
    </>
  );
}
