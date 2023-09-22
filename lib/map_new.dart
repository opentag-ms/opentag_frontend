import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:opentag_frontend/your_position_marker.dart';

class NewMap extends StatefulWidget {
  const NewMap({super.key});

  @override
  State<NewMap> createState() => _NewMapState();
}

class _NewMapState extends State<NewMap> {
  MapController mapController = MapController();

  @override
  void dispose() {
    super.dispose();

    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        zoom: 17,
        maxZoom: 20,
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
              /*builder: (context) => const Icon(
                Icons.local_offer_rounded,
                color: Colors.teal,
                size: 50,
              ),*/
              builder: (context) => const YourPositionMarker(),
            ),
          ],
        ),
        CurrentLocationLayer(
          followOnLocationUpdate: FollowOnLocationUpdate.once,
        ), // <-- add layer here
      ],
    );
  }
}
