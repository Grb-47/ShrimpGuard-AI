import PagePlaceholder from '../components/PagePlaceholder.jsx';

export default function Settings() {
  return (
    <PagePlaceholder
      title="Settings"
      description="Dashboard and account preferences."
      items={[
        'API base URL for local development',
        'Language and notification preferences',
        'Session and token handling',
        'Account management',
      ]}
    />
  );
}
