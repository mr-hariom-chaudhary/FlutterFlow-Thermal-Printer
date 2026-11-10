import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'printer_test_screen_widget.dart' show PrinterTestScreenWidget;
import 'package:flutter/material.dart';

class PrinterTestScreenModel extends FlutterFlowModel<PrinterTestScreenWidget> {
  ///  Local state fields for this page.

  List<String> pairedPrinters = [];
  void addToPairedPrinters(String item) => pairedPrinters.add(item);
  void removeFromPairedPrinters(String item) => pairedPrinters.remove(item);
  void removeAtIndexFromPairedPrinters(int index) =>
      pairedPrinters.removeAt(index);
  void insertAtIndexInPairedPrinters(int index, String item) =>
      pairedPrinters.insert(index, item);
  void updatePairedPrintersAtIndex(int index, Function(String) updateFn) =>
      pairedPrinters[index] = updateFn(pairedPrinters[index]);

  String? selectedPrinter;

  String? printStatus;

  String? selectedUsbPrinter;

  List<String> usbPrinters = [];
  void addToUsbPrinters(String item) => usbPrinters.add(item);
  void removeFromUsbPrinters(String item) => usbPrinters.remove(item);
  void removeAtIndexFromUsbPrinters(int index) => usbPrinters.removeAt(index);
  void insertAtIndexInUsbPrinters(int index, String item) =>
      usbPrinters.insert(index, item);
  void updateUsbPrintersAtIndex(int index, Function(String) updateFn) =>
      usbPrinters[index] = updateFn(usbPrinters[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - listPairedPrinters] action in Button widget.
  List<String>? printersResult;
  // Stores action output result for [Custom Action - listUsbPrinters] action in Button widget.
  List<String>? uSBprintersResult;
  // State field(s) for Dropdown widget.
  String? dropdownValue1;
  FormFieldController<String>? dropdownValueController1;
  // State field(s) for Dropdown widget.
  String? dropdownValue2;
  FormFieldController<String>? dropdownValueController2;
  // Stores action output result for [Custom Action - printEpsonTest] action in Button widget.
  String? printResult;
  // Stores action output result for [Custom Action - printEpsonUsbTest] action in Button widget.
  String? uSBprintResult;
  bool isDataUploading_pickedImagePath = false;
  FFUploadedFile uploadedLocalFile_pickedImagePath =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
