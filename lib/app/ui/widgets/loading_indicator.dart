import 'dart:math';
import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    Key? key,
    this.type,
  }) : super(key: key);

  final String? type;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation<double> rotationAnimation = Tween(begin: 0.0, end: 7 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    return Center(
      child: RotationTransition(
        turns: rotationAnimation,
        child: Image.asset(
          Images.loader,
          height: 36,
          width: 36,
        )
      ),
    );
  }
}
