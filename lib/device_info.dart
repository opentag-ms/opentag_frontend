import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:opentag_frontend/one_device.dart';
import 'package:opentag_frontend/your_position_marker.dart';

class DeviceInfoView extends StatefulWidget {
  const DeviceInfoView({super.key});

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
                        width: 50,
                        height: 50,
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
            const OneDevice(
              name: "name",
              deviceId: "deviceId",
            ),
            Theme(
              data: ThemeData(textTheme: const TextTheme()),
              child: const Column(
                children: [
                  ListTile(
                    leading: Text("In Reichweite"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
