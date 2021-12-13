import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quitouch/view/quitouch_home.dart';

class AnimatedSplashPage extends StatefulWidget {
  AnimatedSplashPage({Key? key}) : super(key: key);
  @override
  _AnimatedSplashPageState createState() => _AnimatedSplashPageState();
}

class _AnimatedSplashPageState extends State<AnimatedSplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(0.5, 0.0),
    end: const Offset(2.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInBack,
  ));

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => QuitouchHome())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(181, 181, 181, 1),
      body: SlideTransition(
        position: _offsetAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('images/quitouch_appIcon.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
