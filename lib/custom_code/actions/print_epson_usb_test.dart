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

Future<String> printEpsonUsbTest(String deviceName) async {
  final manager = PrinterManager();

  try {
    final devices = await manager.scanPrinters(
      types: {PrinterConnectionType.usb},
      timeout: const Duration(seconds: 5),
    );
    final device = devices.firstWhere(
      (d) => d.name == deviceName,
      orElse: () => throw Exception('Device not found'),
    );

    bool connectedOk = false;
    for (int attempt = 0; attempt < 2; attempt++) {
      try {
        await manager.connect(device);
        connectedOk = true;
        break;
      } catch (_) {
        await Future.delayed(const Duration(milliseconds: 1500));
      }
    }
    if (!connectedOk) return 'Connection failed after retry';

    // Step 1: print the text only
    final textTicket = await Ticket.create(PaperSize.mm80);
    textTicket.text(
      'USB Test Print OK',
      align: PrintAlign.center,
      style: const PrintTextStyle(
        bold: true,
        height: TextSize.size2,
        width: TextSize.size2,
      ),
    );
    await manager.printTicket(textTicket);
    await manager.waitWriteComplete();

    // Step 2: wait, then feed several full lines to clear the print head
    await Future.delayed(const Duration(milliseconds: 500));
    final feedTicket = await Ticket.create(PaperSize.mm80);
    feedTicket.feed(5);
    await manager.printTicket(feedTicket);
    await manager.waitWriteComplete();
    await Future.delayed(const Duration(milliseconds: 500));

    // Step 3: cut, as its own isolated command
    final cutTicket = await Ticket.create(PaperSize.mm80);
    cutTicket.cut();
    await manager.printTicket(cutTicket);
    await manager.waitWriteComplete();
    await Future.delayed(const Duration(milliseconds: 1000));

    await manager.disconnect();
    manager.dispose();

    return 'USB print sent successfully';
  } catch (e) {
    manager.dispose();
    return 'USB print failed: $e';
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
