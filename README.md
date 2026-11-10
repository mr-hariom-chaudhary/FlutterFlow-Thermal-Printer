# 🖨️ FlutterFlow Thermal Printer

Print receipts and images to **ESC/POS thermal printers** (e.g. Epson) from a **FlutterFlow / Flutter** app over **Bluetooth** and **USB**.

FlutterFlow has no built-in thermal printing, so this project adds it with **custom actions** you can reuse in any FlutterFlow project.

---

## ✨ Features

- 🔵 **Bluetooth printing**: list paired printers, connect by MAC address, print text receipts
- 🔌 **USB printing**: scan for USB printers and print with automatic connection retry
- 🖼️ **Image printing**: print an uploaded image (logo, QR code, etc.), auto-resized for thermal paper
- ✂️ Paper feed & auto-cut support (80 mm paper)
- 🛡️ Robust handling: Android 12+ Bluetooth permissions, Bluetooth-off detection, stale connection cleanup, chunked writes to avoid buffer overflows, clear error messages

---

## 🧩 Custom Actions

| Action | Description |
|---|---|
| `listPairedPrinters()` | Requests Bluetooth permissions and returns paired devices as `name\|mac` |
| `printEpsonTest(macAddress)` | Connects over Bluetooth and prints a formatted test receipt with feed & cut. Sends data in 512-byte chunks for reliability |
| `printImageTest(macAddress, uploadedFile)` | Decodes, resizes and prints an uploaded image |
| `listUsbPrinters()` | Scans for connected USB printers |
| `printEpsonUsbTest(deviceName)` | Connects over USB (with retry) and prints text, feed and cut as separate commands for stable output |

**Custom function:** `extractMac(String)` extracts the MAC address from a `name|mac` string for use in dropdowns.

📁 Code: [`lib/custom_code/actions/`](lib/custom_code/actions)

---

## 🛠️ Tech Stack

- **FlutterFlow** + **Flutter / Dart**
- [`print_bluetooth_thermal`](https://pub.dev/packages/print_bluetooth_thermal): Bluetooth printing
- [`esc_pos_utils_plus`](https://pub.dev/packages/esc_pos_utils_plus): ESC/POS receipt generation
- [`unified_esc_pos_printer`](https://pub.dev/packages/unified_esc_pos_printer): USB printing
- [`permission_handler`](https://pub.dev/packages/permission_handler): runtime permissions
- [`image`](https://pub.dev/packages/image): image decoding & resizing

---

## ▶️ How to Run

```bash
git clone https://github.com/mr-hariom-chaudhary/FlutterFlow-Thermal-Printer.git
cd FlutterFlow-Thermal-Printer
flutter pub get
flutter run
```

1. Pair your thermal printer in your phone's Bluetooth settings (or connect it by USB/OTG)
2. Open the app and select your printer from the list
3. Tap **Print** to send a test receipt or image

> Runs on a real **Android** device (Bluetooth/USB printing doesn't work on emulators or web).

---

## 📸 Screenshots

<!-- Add screenshots of the app screen and a printed receipt here -->

---

👤 **Hariom Chaudhary**, Flutter Developer · [LinkedIn](https://www.linkedin.com/in/hariom-chaudhary-dev)
