// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

import 'package:unified_esc_pos_printer/unified_esc_pos_printer.dart';

Future<List<String>> listUsbPrinters() async {
  try {
    final manager = PrinterManager();
    final devices = await manager.scanPrinters(
      types: {PrinterConnectionType.usb},
      timeout: const Duration(seconds: 5),
    );
    if (devices.isEmpty) {
      return ['ERROR|No USB printers found'];
    }
    return devices.map((d) => '${d.name}|${d.name}').toList();
  } catch (e) {
    return ['ERROR|$e'];
  }
}
