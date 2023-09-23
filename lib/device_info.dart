import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:opentag_frontend/app.dart';
import 'package:opentag_frontend/data/server_service.dart';
import 'package:opentag_frontend/data/settings_service.dart';
import 'package:opentag_frontend/one_device.dart';
import 'package:opentag_frontend/share_deice.dart';
import 'package:opentag_frontend/your_position_marker.dart';

class DeviceInfoView extends StatefulWidget {
  final String name;
  final String deviceId;

  const DeviceInfoView({
    super.key,
    required this.name,
    required this.deviceId,
  });

  @override
  State<DeviceInfoView> createState() => _DeviceInfoViewState();
}

class _DeviceInfoViewState extends State<DeviceInfoView> {
  MapController mapController = MapController();

  @override
  void dispose() {
    super.dispose();

    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white70,
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  zoom: 17,
                  maxZoom: 20,
                  onMapReady: () => mapController.move(const LatLng(51.951475, 7.638143), 17),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'opentag.ms',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: const LatLng(51.951475, 7.638143),
                        width: 100,
                        height: 100,
                        builder: (context) => const YourPositionMarker(),
                      ),
                    ],
                  ),

                  CurrentLocationLayer(), // <-- add layer here
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Geräteinformationen",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            OneDevice(
              name: widget.name,
              deviceId: widget.deviceId,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: Divider(),
            ),
            Row(
              children: [
                //################################## Hinzufuegen
                if (!SettingsService().ownedTags.contains(widget.deviceId))
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 12),
                    child: GestureDetector(
                      onTap: () async {
                        await ServerService().registerDevice(widget.deviceId, widget.name);

                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const App()), (route) => false);
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green.shade700,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 40,
                              color: Colors.white70,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Hinzufügen",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                //#################################### Entfernen
                if (SettingsService().ownedTags.contains(widget.deviceId))
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 12),
                    child: GestureDetector(
                      onTap: () async {
                        await ServerService().unregisterDevice(widget.deviceId);
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const App()), (route) => false);
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red.shade700,
                            ),
                            child: const Icon(
                              Icons.delete,
                              size: 40,
                              color: Colors.white70,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Entfernen",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                //######################################### Teilen
                if (SettingsService().ownedTags.contains(widget.deviceId))
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 12),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShareDevice(
                                    deviceId: widget.deviceId,
                                    name: widget.name,
                                  ))),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.share,
                              size: 40,
                              color: Colors.white70,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Teilen",
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
          ],
        ),
      ),
    );
  }
}
