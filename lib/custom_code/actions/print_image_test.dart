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
import 'package:image/image.dart' as img;
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

Future<String> printImageTest(
    String macAddress, FFUploadedFile uploadedFile) async {
  final bool connected =
      await PrintBluetoothThermal.connect(macPrinterAddress: macAddress);
  if (!connected) return 'Connection failed';

  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm80, profile);

  final Uint8List? imageBytes = uploadedFile.bytes;
  if (imageBytes == null) return 'No image data found';

  final img.Image? decodedImage = img.decodeImage(imageBytes);
  if (decodedImage == null) return 'Failed to decode image';

  final img.Image resized = img.copyResize(decodedImage, width: 384);

  List<int> bytes = [];
  bytes += generator.image(resized);
  bytes += generator.feed(2);
  bytes += generator.cut();

  final bool result = await PrintBluetoothThermal.writeBytes(bytes);
  await PrintBluetoothThermal.disconnect;

  return result ? 'Image printed successfully' : 'Print failed';
}
