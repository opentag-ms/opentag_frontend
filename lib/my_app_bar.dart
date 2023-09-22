import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:opentag_frontend/data/ble_service.dart';

class MyAppBar extends StatelessWidget {
  final Widget child;

  const MyAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        child,
        Container(
          width: width * 0.9,
          height: 50,
          margin: const EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),
              const Text(
                "OpenTag-MS",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  BleService();
                  BleService().initBle();
                },
                icon: const Icon(
                  Icons.bluetooth,
                  color: Colors.white70,
                ),
              ),
              StreamBuilder(
                stream: FlutterBluePlus.adapterState,
                builder: (context, snapshot) {
                  if (snapshot.hasError) return const SizedBox();
                  if (!snapshot.hasData) return const SizedBox();

                  snapshot.data!.name;

                  return Text(snapshot.data!.name);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
