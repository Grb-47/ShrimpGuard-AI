import PagePlaceholder from '../components/PagePlaceholder.jsx';

export default function RiskReports() {
  return (
    <PagePlaceholder
      title="Risk Reports"
      description="Review rule-based environmental risk classifications and Bengali explanations."
      items={[
        'Risk level and foundation score',
        'Contributing factors and trends',
        'Gemini-generated Bengali explanation',
        'Linked farmer recommendations',
      ]}
    />
  );
}
