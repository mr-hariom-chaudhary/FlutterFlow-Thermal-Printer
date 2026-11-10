// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List<String>> listPairedPrinters() async {
  try {
    final statuses = await [
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
    ].request();

    if (!(statuses[Permission.bluetoothConnect]?.isGranted ?? false)) {
      return ['ERROR|Bluetooth permission not granted'];
    }

    final bool btOn = await PrintBluetoothThermal.bluetoothEnabled;
    if (!btOn) {
      return ['ERROR|Bluetooth is turned off'];
    }

    final List<BluetoothInfo> devices =
        await PrintBluetoothThermal.pairedBluetooths;

    if (devices.isEmpty) {
      return ['ERROR|No paired printers found'];
    }

    return devices.map((d) => '${d.name}|${d.macAdress}').toList();
  } catch (e) {
    return ['ERROR|$e'];
  }
}
