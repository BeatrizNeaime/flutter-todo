import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _scale = 1.0;
  var _animationOpacity = 0.0;
  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 100 * _scale;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _scale = 3.0;
        _animationOpacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AnimatedOpacity(
        opacity: _animationOpacity,
        duration: const Duration(seconds: 2),
        curve: Curves.bounceIn,
        onEnd: () => Navigator.of(context).popAndPushNamed("/todo"),
        child: Container(
          height: 128,
          padding:
              const EdgeInsets.only(top: 20.0, bottom: 20, left: 40, right: 40),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: const Offset(0, 3),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: const Column(
            children: [
              Text(
                "To Do",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'OpenSans',
                ),
              ),
              Icon(
                Icons.check,
                color: Colors.white,
                size: 54,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
