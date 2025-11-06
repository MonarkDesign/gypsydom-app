import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool isFront = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (isFront) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      isFront = !isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5E2F75),
      body: Center(
        child: GestureDetector(
          onTap: _flipCard,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final angle = _controller.value * pi;
              final isUnder = angle > pi / 2;
              final transform = Matrix4.rotationY(angle);
              return Transform(
                alignment: Alignment.center,
                transform: transform,
                child: isUnder
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: Image.asset(
                          'assets/cards/ace_of_cups.png',
                          width: 250,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/back/tarot_back.png',
                        width: 250,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}

