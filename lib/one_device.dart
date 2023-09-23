import 'package:flutter/material.dart';
import 'package:opentag_frontend/device_info.dart';

class OneDevice extends StatelessWidget {
  final String name;
  final String deviceId;
  final bool inRange;

  const OneDevice({
    super.key,
    required this.name,
    required this.deviceId,
    this.inRange = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceInfoView(
              name: name,
              deviceId: deviceId,
            ),
          ),
        );
      },
      leading: const Icon(
        Icons.local_offer_outlined,
        color: Colors.white70,
        size: 40,
      ),
      title: Text(
        name.isEmpty ? "-" : name,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        deviceId,
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
      trailing: inRange
          ? const Icon(
              Icons.wifi,
              color: Colors.green,
            )
          : null,
    );
  }
}
