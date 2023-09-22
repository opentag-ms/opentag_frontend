import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:opentag_frontend/ble_results.dart';
import 'package:opentag_frontend/data/ble_service.dart';
import 'package:opentag_frontend/device_info.dart';
import 'package:opentag_frontend/settings/settings.dart';

class ContentView extends StatelessWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Geräte",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StreamBuilder(
                stream: FlutterBluePlus.isScanning,
                builder: (context, snapshot) {
                  if (snapshot.hasError) return const SizedBox();
                  if (!snapshot.hasData) return const SizedBox();
                  if (!snapshot.data!) return const SizedBox();

                  return const Padding(
                    padding: EdgeInsets.only(left: 8, top: 12),
                    child: Text(
                      "suche läuft...",
                      style: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.replay_outlined,
                  color: Colors.white70,
                  size: 26,
                ),
                onPressed: () {
                  BleService().scan();
                },
              ),
            ],
          ),
          const BleResultsView(),
          const Divider(),
          const SizedBox(height: 10),
          const Text(
            "Einstellungen",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*InkWell(
                      onTap: () {},
                      //borderRadius: BorderRadius.circular(10),
                      child: Ink(
                        width: 100,
                        height: 100,
                        color: Colors.green,
                        //child: const Icon(Icons.privacy_tip_rounded),
                      ),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DeviceInfoView())),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade800,
                              ),
                              child: const Icon(
                                Icons.privacy_tip_rounded,
                                size: 40,
                                color: Colors.white70,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                "Schutz",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade800,
                              ),
                              child: const Icon(
                                Icons.list_rounded,
                                size: 40,
                                color: Colors.white70,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                "Deine Geräte",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SettingsView(),
          const SizedBox(height: 600),
        ],
      ),
    );
  }
}
