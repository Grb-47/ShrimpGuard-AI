import PagePlaceholder from '../components/PagePlaceholder.jsx';

export default function Notifications() {
  return (
    <PagePlaceholder
      title="Notifications"
      description="Alerts generated from risky pond conditions and device events."
      items={[
        'Unread and read notifications',
        'Pond and risk report links',
        'In-app delivery in this phase',
        'Push and SMS delivery are future work',
      ]}
    />
  );
}
