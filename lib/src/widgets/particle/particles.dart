import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_animations/simple_animations.dart';

import 'particleModel.dart';
import 'particlePainter.dart';

const _IMAGE_LIST = [
  'assets/icons/leaf-1.png',
  'assets/icons/leaf-2.png',
  'assets/icons/leaf-3.png',
  'assets/icons/leaf-4.png',
];

class Particles extends StatefulWidget {
  final int numberOfParticles;
  final double speed;

  Particles(this.numberOfParticles, {this.speed = 1});

  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  final List<ParticleModel> particles = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(),
      builder: (context, snapshot) {
        return Rendering(
          startTime: Duration(seconds: 30),
          onTick: _simulateParticles,
          builder: (context, time) {
            return CustomPaint(
              painter: ParticlePainter(particles, time),
            );
          },
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }

  Future _loadImage() async {
    final List<ByteData> data = await Future.wait<ByteData>(
        _IMAGE_LIST.map((e) => rootBundle.load(e)).toList());

    final images = await Future.wait(data
        .map((e) => decodeImageFromList(new Uint8List.view(e.buffer)))
        .toList());

    List.generate(widget.numberOfParticles, (index) {
      particles.add(
        ParticleModel(
          random,
          image: images.elementAt(
            random.nextInt(_IMAGE_LIST.length),
          ),
        ),
      );
    });
  }
}
