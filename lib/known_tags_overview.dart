import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:opentag_frontend/data/settings_service.dart';
import 'package:opentag_frontend/one_device.dart';

class KnownTagsOverview extends StatefulWidget {
  final List<ScanResult> scanResults;

  const KnownTagsOverview({super.key, required this.scanResults});

  @override
  State<KnownTagsOverview> createState() => _KnownTagsOverviewState();
}

class _KnownTagsOverviewState extends State<KnownTagsOverview> {
  @override
  void initState() {
    super.initState();

    

    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {});
      debugPrint("nach 2");
      debugPrint(SettingsService().ownedTags.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (SettingsService().ownedTags.isEmpty) return const SizedBox();

    return Column(
      children: [
        for (String tagId in SettingsService().ownedTags)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(10),
            ),
            child: OneDevice(
              name: SettingsService().getTagName(tagId),
              deviceId: tagId,
              inRange: widget.scanResults.map((e) => e.device.remoteId.str).contains(tagId),
            ),
          ),
        if(widget.scanResults.isNotEmpty)
        const Divider(),
      ],
    );
  }
}
