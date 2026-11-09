import PagePlaceholder from '../components/PagePlaceholder.jsx';

export default function Ponds() {
  return (
    <PagePlaceholder
      title="Ponds"
      description="Monitor ponds, assigned devices, and the latest water-quality state."
      items={[
        'Pond list grouped by farm',
        'Latest readings per parameter',
        'Device and calibration status',
        'Manual ammonia test history',
      ]}
    />
  );
}
