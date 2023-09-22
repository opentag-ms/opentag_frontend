import 'package:flutter/material.dart';

class OneDevice extends StatelessWidget {
  final String name;
  final String deviceId;

  const OneDevice({
    super.key,
    required this.name,
    required this.deviceId,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
