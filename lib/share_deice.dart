import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareDevice extends StatelessWidget {
  final String deviceId;
  final String name;

  const ShareDevice({super.key, required this.deviceId, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white70,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Row(
                children: [
                  Text(
                    "Teilen beenden",
                    style: TextStyle(color: Colors.red),
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ],
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: '{"n":"$name","id":"$deviceId"}',
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
