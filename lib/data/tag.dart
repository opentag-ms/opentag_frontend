import 'package:latlong2/latlong.dart';

class Tag {
  String name;
  String id;
  LatLng latLng;

  Tag(
    this.name,
    this.id,
    this.latLng,
  );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "lat": latLng.latitude,
      "lng": latLng.longitude,
    };
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      json["name"],
      json["id"],
      LatLng(
        json["lat"],
        json["lng"],
      ),
    );
  }
}
