import 'dart:math';

import 'package:flutter/material.dart';
class AnimatedLoadingDots extends StatefulWidget {
  final List<Color> colors;

  const AnimatedLoadingDots({super.key, required this.colors});

  @override
  State<AnimatedLoadingDots> createState() => _AnimatedLoadingDotsState();
}

class _AnimatedLoadingDotsState extends State<AnimatedLoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAnimatedDot(0, widget.colors[0]),
        const SizedBox(width: 7),
        _buildAnimatedDot(1, widget.colors[1]),
        const SizedBox(width: 7),
        _buildAnimatedDot(2, widget.colors[2]),
      ],
    );
  }

  Widget _buildAnimatedDot(int index, Color baseColor) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final delay = index * 0.2;
        final value = (_controller.value - delay) % 1.0;
        final opacity = 0.3 + (sin(value * pi * 2) * 0.5 + 0.5) * 0.7;

        return Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: baseColor.withOpacity(opacity * baseColor.opacity),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}