import 'package:flutter/material.dart';

class YourPositionMarker extends StatefulWidget {
  const YourPositionMarker({super.key});

  @override
  State<YourPositionMarker> createState() => _YourPositionMarkerState();
}

class _YourPositionMarkerState extends State<YourPositionMarker> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.blue, end: Colors.transparent).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ),
    );

    // In initState
    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(90),
          ),
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: animation.value,
            borderRadius: BorderRadius.circular(90),
            border: Border.all(
              color: animation.value,
              width: 5,
            ),
          ),
        ),
      ],
    );
  }
}