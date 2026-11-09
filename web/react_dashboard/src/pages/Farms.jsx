import PagePlaceholder from '../components/PagePlaceholder.jsx';

export default function Farms() {
  return (
    <PagePlaceholder
      title="Farms"
      description="Manage farms owned by registered farmers."
      items={[
        'List farms with location and area',
        'Create and edit farms',
        'Open ponds belonging to a farm',
      ]}
    />
  );
}
