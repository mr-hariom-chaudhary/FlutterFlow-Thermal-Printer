// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> printEpsonTest(String macAddress) async {
  try {
    // 1. Permission check (needed on Android 12+)
    final perm = await Permission.bluetoothConnect.request();
    if (!perm.isGranted) return 'Bluetooth permission denied';

    // 2. Bluetooth must be on
    final bool btOn = await PrintBluetoothThermal.bluetoothEnabled;
    if (!btOn) return 'Bluetooth is turned off';

    // 3. Clear any stale connection
    await PrintBluetoothThermal.disconnect;
    await Future.delayed(const Duration(milliseconds: 500));

    // 4. Connect
    final bool connected =
        await PrintBluetoothThermal.connect(macPrinterAddress: macAddress);
    if (!connected) return 'Connection failed';

    // 5. Let the socket settle, then verify it is still open
    await Future.delayed(const Duration(milliseconds: 800));
    final bool stillConnected = await PrintBluetoothThermal.connectionStatus;
    if (!stillConnected) return 'Connected, but socket dropped before write';

    // 6. Build the receipt
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);

    List<int> bytes = [];
    bytes += generator.text(
      'Test Print OK',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );
    bytes += generator.feed(2);
    bytes += generator.cut();

    // 7. Send in small chunks
    const int chunk = 512;
    for (int i = 0; i < bytes.length; i += chunk) {
      final int end = (i + chunk < bytes.length) ? i + chunk : bytes.length;
      final bool ok =
          await PrintBluetoothThermal.writeBytes(bytes.sublist(i, end));
      if (!ok) return 'Write failed at byte $i of ${bytes.length}';
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // 8. Wait for the printer to finish, then disconnect
    await Future.delayed(const Duration(milliseconds: 800));
    await PrintBluetoothThermal.disconnect;

    return 'Print sent successfully';
  } catch (e) {
    return 'Print error: $e';
  }
}
