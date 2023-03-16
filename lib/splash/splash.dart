import 'package:chatty/shared/components/components.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  final Widget startWidget;

  Splash({Key? key, required this.startWidget}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(Duration(seconds: 5));
    navigatAndReplace(context, widget.startWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/images/chat.json'),
      ),
    );
  }
}
