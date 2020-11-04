
import 'package:flutter/material.dart';
import 'package:flutter_particle_animation_dem/splash_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
