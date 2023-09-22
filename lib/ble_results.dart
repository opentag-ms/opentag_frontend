import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:opentag_frontend/data/ble_service.dart';
import 'package:opentag_frontend/one_device.dart';

class BleResultsView extends StatelessWidget {
  const BleResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterBluePlus.scanResults,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("No data");
        }
        if (snapshot.hasError) {
          return const Text("Error");
        }

        List<ScanResult> results = snapshot.data ?? [];

        List<ScanResult> resultsCleaned = [];

        for (ScanResult scanResult in results) {
          String text = "";

          text = scanResult.advertisementData.localName;

          if (text.isEmpty) text = scanResult.device.localName;

          if (text.isEmpty) continue;

          if (text.isEmpty) text = scanResult.device.remoteId.toString();

          resultsCleaned.add(scanResult);
        }

        return Column(
          children: [
            if (resultsCleaned.isEmpty) const Text("Keine Geräte"),
            for (ScanResult scanResult in resultsCleaned)
              OneDevice(
                name: scanResult.advertisementData.localName,
                deviceId: scanResult.device.remoteId.str,
              ),
            StreamBuilder(
              stream: FlutterBluePlus.isScanning,
              builder: (context, snapshot) {
                if (snapshot.hasError) return const SizedBox();
                if (!snapshot.hasData) return const SizedBox();
                if (!snapshot.data!) return const SizedBox();

                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: CupertinoButton(
                      color: Colors.grey.shade800,
                      child: Text(
                        "Suche beenden",
                        style: TextStyle(
                          color: Colors.orange.shade900,
                        ),
                      ),
                      onPressed: () {
                        BleService().stopScan();
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
