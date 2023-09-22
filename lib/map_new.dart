import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class NewMap extends StatefulWidget {
  const NewMap({super.key});

  @override
  State<NewMap> createState() => _NewMapState();
}

class _NewMapState extends State<NewMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        zoom: 17,
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
              builder: (context) => const Icon(
                Icons.local_offer_rounded,
                color: Colors.teal,
                size: 50,
              ),
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
