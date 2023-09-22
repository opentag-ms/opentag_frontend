import 'package:flutter/material.dart';
import 'package:opentag_frontend/content.dart';
import 'package:opentag_frontend/map_new.dart';
import 'package:opentag_frontend/my_app_bar.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingSheet(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          // Enable snapping. This is true by default.
          snap: true,
          // Set custom snapping points.
          snappings: [0.1, 0.9],
          // Define to what the snappings relate to. In this case,
          // the total available space that the sheet can expand to.
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        // The body widget will be displayed under the SlidingSheet
        // and a parallax effect can be applied to it.
        body: const MyAppBar(
          child: NewMap(),
        ),
        color: Colors.grey.shade900,
        headerBuilder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: 50,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          );
        },
        builder: (context, state) {
          // This is the content of the sheet that will get
          // scrolled, if the content is bigger than the available
          // height of the sheet.
          return const ContentView();
        },
      ),
    );
  }
}
