import 'dart:math';

import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  // Declare the animation controller and animation
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );

    // Initialize the animation
    _animation = Tween<double>(begin: -pi / 6, end: pi / 6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Dispose the animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: const Color(0xFF624EFF),
      height: height,
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Transform(
            alignment: Alignment.topCenter,
            transform: Matrix4.identity()..rotateZ(_animation.value),
            child: Image.asset(
              'assets/bell_icon.png',
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
