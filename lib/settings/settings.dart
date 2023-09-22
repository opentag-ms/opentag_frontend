import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opentag_frontend/data/settings_service.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            "App aktiv",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 24,
            ),
          ),
          trailing: CupertinoSwitch(
            value: SettingsService().killSwitch,
            onChanged: (_) => setState(() {
              SettingsService().killSwitch = !SettingsService().killSwitch;
            }),
          ),
        ),
        ListTile(
          title: const Text(
            "Collect Peer Data",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 24,
            ),
          ),
          trailing: CupertinoSwitch(
            value: SettingsService().collectPeerData,
            onChanged: (_) => setState(() {
              SettingsService().collectPeerData = !SettingsService().collectPeerData;
            }),
          ),
        ),
      ],
    );
  }
}
