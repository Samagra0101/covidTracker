import 'dart:async';
import 'package:covid_app/view/world_stats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
   const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(duration: Duration(seconds: 4),vsync: this)..repeat();
  
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  void initState(){
    super.initState();

    Timer(const Duration(seconds: 6),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStats()))
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              child: Container(
               height: 200,
                width: 200,
                child: Center(
                  child: Image(image: AssetImage('assets/images/img.png')),
                ),
              ),
              builder: (BuildContext context, Widget?child){
                return Transform.rotate(
                  angle: _controller.value*2.0*math.pi,
                child: child,);
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.08,
          ),
          Align(
            alignment: Alignment.center,
            child: Text('Covid Tracker',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),),
          )
        ],
      )
      ),
    );
  }
}
