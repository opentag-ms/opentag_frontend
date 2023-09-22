import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:opentag_frontend/your_position_marker.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapController mapController = MapController.withUserPosition(
    trackUserLocation: const UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
  );

  @override
  void dispose() {
    mapController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: mapController,
      onMapIsReady: (p0) {
        mapController.addMarker(
          GeoPoint(latitude: 51.951475, longitude: 7.638143),
          markerIcon: const MarkerIcon(
            icon: Icon(
              Icons.local_offer_rounded,
              color: Colors.teal,
              size: 50,
            ),
          ),
        );
        mapController.addMarker(
          GeoPoint(latitude: 51.951177, longitude: 7.641923),
          markerIcon: const MarkerIcon(
            icon: Icon(
              Icons.local_offer_rounded,
              color: Colors.teal,
              size: 50,
            ),
          ),
        );
      },
      osmOption: OSMOption(
        userTrackingOption: const UserTrackingOption(
          enableTracking: true,
          unFollowUser: false,
        ),
        zoomOption: const ZoomOption(
          initZoom: 16,
          minZoomLevel: 6,
          maxZoomLevel: 19,
          stepZoom: 1.0,
        ),
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            iconWidget: YourPositionMarker(),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
              color: Colors.amber,
            ),
          ),
        ),
        roadConfiguration: const RoadOption(
          roadColor: Colors.green,
          
        ),
        markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 56,
            ),
          ),

        ),

        showZoomController: true,
      ),

    );
  }
}
