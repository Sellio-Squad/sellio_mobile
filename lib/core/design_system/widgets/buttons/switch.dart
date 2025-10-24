import 'package:flutter/material.dart';

class DesignSwitch extends StatefulWidget {
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const DesignSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  State<DesignSwitch> createState() => _DesignSwitchState();
}

class _DesignSwitchState extends State<DesignSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.value ? 1.0 : 0.0,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(DesignSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    const onColor = Color(0xFF520826);
    const offColor = Color(0xFFFFFFFF);
    const disabledColor = Color(0xFFE8EBED);

    const thumbOn = Color(0xFFEAE0E5);
    const thumbOff = Color(0x611F1F1F); // 38% opacity
    const thumbDisabled = Color(0x611F1F1F);

    return GestureDetector(
      onTap: widget.enabled
          ? () => widget.onChanged(!widget.value)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 32,
        decoration: BoxDecoration(
          color: widget.enabled
              ? (widget.value ? onColor : offColor)
              : disabledColor,
          borderRadius: BorderRadius.circular(100),
          border: widget.enabled
              ? null
              : Border.all(color: disabledColor, width: 2),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final left = widget.enabled
                    ? (widget.value ? 28.0 : 4.0)
                    : 4.0; // thumb movement
                final thumbSize = widget.enabled
                    ? (widget.value ? 24.0 : 16.0)
                    : 16.0;
                final thumbColor = widget.enabled
                    ? (widget.value ? thumbOn : thumbOff)
                    : thumbDisabled;

                return Positioned(
                  top: (32 - thumbSize) / 2,
                  left: left,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      color: thumbColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
