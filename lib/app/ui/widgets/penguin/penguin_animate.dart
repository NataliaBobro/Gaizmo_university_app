import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/resources.dart';


class AnimatedPenguinSplash extends StatefulWidget {
  const AnimatedPenguinSplash({
    super.key,
    this.width = 80
  });

  final double width;

  @override
  State<AnimatedPenguinSplash> createState() => _AnimatedPenguinSplashState();
}

class _AnimatedPenguinSplashState extends State<AnimatedPenguinSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    sizeAnimation = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _animation.addListener(() {
      if (_animation.isCompleted) {
        startSecondAnimation();
      }
    });

    _controller.forward();

  }

  void startSecondAnimation() {
    sizeAnimation = Tween<double>(
      begin: 0.579,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInExpo,
      ),
    );
    sizeAnimation.addListener(() {
      setState(() {});
    });
    _controller.animateTo(.65);
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        height: SizerUtil.height,
        child: SlideTransition(
            position: _animation,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                scale: sizeAnimation.value,
                  child: SizedBox(
                    width: widget.width,
                    height: widget.width,
                    child: Image.asset(
                      Images.penguins,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            )
        )
      ),
    );
  }
}

class AnimatedPenguinLoginType extends StatefulWidget {
  const AnimatedPenguinLoginType({
    Key? key
  }) : super(key: key);

  @override
  State<AnimatedPenguinLoginType> createState() => _AnimatedPenguinLoginTypeState();
}

class _AnimatedPenguinLoginTypeState extends State<AnimatedPenguinLoginType> {
  @override
  Widget build(BuildContext context) {

    return IgnorePointer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              Images.penguins,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}

