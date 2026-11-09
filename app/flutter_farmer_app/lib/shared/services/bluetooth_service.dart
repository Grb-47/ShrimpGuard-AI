enum BluetoothConnectionState {
  disconnected,
  scanning,
  connecting,
  connected,
}

class BluetoothDeviceInfo {
  const BluetoothDeviceInfo({required this.id, required this.name});

  final String id;
  final String name;
}

/// Bluetooth transport placeholder.
///
/// The ESP32 Bluetooth profile, service UUIDs, and payload format are
/// To Be Confirmed. A Flutter Bluetooth package will be selected after the
/// hardware protocol is finalized.
class BluetoothService {
  BluetoothConnectionState _state = BluetoothConnectionState.disconnected;

  BluetoothConnectionState get state => _state;

  Future<List<BluetoothDeviceInfo>> scan() async {
    _state = BluetoothConnectionState.scanning;
    _state = BluetoothConnectionState.disconnected;
    return const [];
  }

  Future<void> connect(String deviceId) async {
    _state = BluetoothConnectionState.connecting;
    throw UnimplementedError(
      'Bluetooth connection is To Be Confirmed. Device id: $deviceId',
    );
  }

  Future<void> disconnect() async {
    _state = BluetoothConnectionState.disconnected;
  }
}
