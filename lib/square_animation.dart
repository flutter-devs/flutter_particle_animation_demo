import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_particle_animation_dem/square_particle.dart';
import 'package:sa_v1_migration/sa_v1_migration.dart';
import 'package:simple_animations/simple_animations.dart';


class SquareAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Particle Animation User Interaction Demo",style: TextStyle(fontSize: 17),),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Wait for the square particle and tap it",),
          ...Iterable.generate(7).map((i) => rowWith2Square()),
        ],
      ),
    );
  }

  Widget rowWith2Square() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[Square(), Square()],
    );
  }
}

class Square extends StatefulWidget {
  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square> {
  final List<SquareParticle> particles = [];

  bool _squaresVisible = false;

  @override
  void initState() {
    _restartSquare();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      child: _buildSquare(),
    );
  }

  Rendering _buildSquare() {
    return Rendering(
      onTick: (time) => _manageParticleLife(time),
      builder: (context, time) {
        return Stack(
          overflow: Overflow.visible,
          children: [
            if (_squaresVisible)
              GestureDetector(onTap: () => _hitSquare(time), child: _square()),
            ...particles.map((it) => it.buildWidget(time))
          ],
        );
      },
    );
  }

  Widget _square() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.redAccent, shape: BoxShape.rectangle ),
    );
  }

  _hitSquare(Duration time) {
    _setSquareVisible(false);
    Iterable.generate(50).forEach((i) => particles.add(SquareParticle(time)));
  }

  void _restartSquare() async {
    var respawnTime = Duration(milliseconds: 2000 + Random().nextInt(8000));
    await Future.delayed(respawnTime);
    _setSquareVisible(true);

    var timeVisible = Duration(milliseconds: 500 + Random().nextInt(1500));
    await Future.delayed(timeVisible);
    _setSquareVisible(false);

    _restartSquare();
  }

  _manageParticleLife(Duration time) {
    particles.removeWhere((particle) {
      return particle.progress.progress(time) == 1;
    });
  }

  void _setSquareVisible(bool visible) {
    setState(() {
      _squaresVisible = visible;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}




