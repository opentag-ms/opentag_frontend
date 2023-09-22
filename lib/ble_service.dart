import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleService {
  static final BleService _instance = BleService._private();
  factory BleService() => _instance;
  BleService._private() {
    debugPrint("Starting BleService Service");
  }

  void initBle() async {
    // check adapter availability
    // Note: The platform is initialized on the first call to any FlutterBluePlus method.
    if (await FlutterBluePlus.isAvailable == false) {
      debugPrint("Bluetooth not supported by this device");
      return;
    }

    // turn on bluetooth ourself if we can
    // for iOS, the user controls bluetooth enable/disable
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    // wait bluetooth to be on & print states
    // note: for iOS the initial state is typically BluetoothAdapterState.unknown
    // note: if you have permissions issues you will get stuck at BluetoothAdapterState.unauthorized
    await FlutterBluePlus.adapterState
        .map((s) {
          debugPrint(s.toString());
          return s;
        })
        .where((s) => s == BluetoothAdapterState.on)
        .first;
  }

  void scan() async {
    // Setup Listener for scan results.
    // device not found? see "Common Problems" in the README
    /*Set<DeviceIdentifier> seen = {};
    var subscription = FlutterBluePlus.scanResults.listen(
      (results) {
        for (ScanResult r in results) {
          if (seen.contains(r.device.remoteId) == false) {
            debugPrint('${r.device.remoteId}: "${r.device.localName}" found! rssi: ${r.rssi}');
            seen.add(r.device.remoteId);
          }
        }
      },
      //onError(e) => print(e);
    );*/
    //FlutterBluePlus.scanResults.listen((event) { })

    // Start scanning
    // Note: You should always call `scanResults.listen` before you call startScan!
    await FlutterBluePlus.startScan(
      androidUsesFineLocation: true,
      removeIfGone: const Duration(
        seconds: 20,
      ),
    );
  }

  void stopScan() async {
    // Stop scanning
    await FlutterBluePlus.stopScan();
  }
}
