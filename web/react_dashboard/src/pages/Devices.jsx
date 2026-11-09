import PagePlaceholder from '../components/PagePlaceholder.jsx';

export default function Devices() {
  return (
    <PagePlaceholder
      title="Devices"
      description="Register ESP32 devices and review their connectivity and sensors."
      items={[
        'Device serial and assigned pond',
        'Online/offline status and last seen time',
        'Installed sensors and firmware version',
        'Bluetooth protocol is To Be Confirmed',
      ]}
    />
  );
}
