import 'package:flutter/material.dart';

class YourPositionMarker extends StatefulWidget {
  const YourPositionMarker({super.key});

  @override
  State<YourPositionMarker> createState() => _YourPositionMarkerState();
}

class _YourPositionMarkerState extends State<YourPositionMarker> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation sizeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    animation = ColorTween(begin: Colors.white, end: Colors.blue).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
    sizeAnimation = Tween<double>(begin: 40, end: 60).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
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
    //debugPrint(sizeAnimation.value.toString());

    return Center(
      child: GestureDetector(
        onTap: () {
          debugPrint("Tapped on position!");
        },
        //behavior: HitTestBehavior.translucent,
        child: Container(
          width: sizeAnimation.value,
          height: sizeAnimation.value,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(90),
            border: Border.all(
              color: animation.value,
              width: 10,
            ),
          ),
        ),
      ),
    );
  }
}
