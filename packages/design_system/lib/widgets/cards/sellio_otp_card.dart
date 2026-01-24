import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/sellio_colors.dart';

enum SellioOTPInputState { defaultState, focused, filled }

class OTPInputCard extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;
  final VoidCallback? onBackspacePressed;

  const OTPInputCard({
    super.key,
    this.onChanged,
    this.onCompleted,
    this.focusNode,
    this.nextFocusNode,
    this.previousFocusNode,
    this.onBackspacePressed,
  });

  @override
  State<OTPInputCard> createState() => _SellioOTPInputCardState();
}

class _SellioOTPInputCardState extends State<OTPInputCard> {
  SellioOTPInputState _currentState = SellioOTPInputState.defaultState;
  String _value = '';
  late FocusNode _internalFocusNode;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _internalFocusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      if (_internalFocusNode.hasFocus) {
        _currentState = SellioOTPInputState.focused;
        _controller.text = _value;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      } else {
        if (_value.isEmpty) {
          _currentState = SellioOTPInputState.defaultState;
        } else {
          _currentState = SellioOTPInputState.filled;
        }
      }
    });
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return false;

    if (event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_value.isEmpty) {
        widget.onBackspacePressed?.call();
        if (widget.previousFocusNode != null) {
          Future.microtask(() {
            widget.previousFocusNode!.requestFocus();
          });
        }
        return true;
      }
    }
    return false;
  }

  void _handleInput(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty && _value.isNotEmpty) {
      setState(() {
        _value = '';
        _currentState = _internalFocusNode.hasFocus
            ? SellioOTPInputState.focused
            : SellioOTPInputState.defaultState;
      });
      widget.onChanged?.call('');
      _controller.clear();
      return;
    }

    if (trimmedValue.length == 1 && RegExp(r'^[0-9]$').hasMatch(trimmedValue)) {
      setState(() {
        _value = trimmedValue;
        _currentState = SellioOTPInputState.filled;
      });
      widget.onChanged?.call(trimmedValue);
      widget.onCompleted?.call(trimmedValue);

      _controller.clear();

      if (widget.nextFocusNode != null) {
        widget.nextFocusNode!.requestFocus();
      } else {
        _internalFocusNode.unfocus();
      }
    } else if (trimmedValue.length > 1) {
      // Extract only digits from pasted content
      final digitsOnly = trimmedValue.replaceAll(RegExp(r'[^0-9]'), '');

      if (digitsOnly.isNotEmpty) {
        // Take first digit for current field
        final firstDigit = digitsOnly[0];
        setState(() {
          _value = firstDigit;
          _currentState = SellioOTPInputState.filled;
        });
        widget.onChanged?.call(firstDigit);

        // Pass all digits to parent - let parent handle focus
        widget.onCompleted?.call(digitsOnly);

        _controller.clear();
      }
    }
  }

  Color _getBorderColor(BuildContext context) {
    final colors = Theme.of(context).extension<SellioColorScheme>() ?? SellioColors.light;

    switch (_currentState) {
      case SellioOTPInputState.focused:
        return colors.primary;
      case SellioOTPInputState.defaultState:
      case SellioOTPInputState.filled:
        return colors.stroke;
    }
  }

  double _getBorderWidth() {
    return _currentState == SellioOTPInputState.focused ? 1.0 : 0.5;
  }

  Color _getBackgroundColor(BuildContext context) {
    final colors = Theme.of(context).extension<SellioColorScheme>() ?? SellioColors.light;

    return _currentState == SellioOTPInputState.focused
        ? colors.surfaceLow
        : colors.surface;
  }

  void clear() {
    setState(() {
      _value = '';
      _controller.clear();
      _currentState = SellioOTPInputState.defaultState;
    });
  }

  void setValue(String value) {
    setState(() {
      _value = value;
      _currentState = SellioOTPInputState.filled;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<SellioColorScheme>() ?? SellioColors.light;

    return GestureDetector(
      onTap: () {
        _internalFocusNode.requestFocus();
      },
      child: Container(
        width: 68,
        height: 106,
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _getBorderColor(context),
            width: _getBorderWidth(),
          ),
          boxShadow: _currentState == SellioOTPInputState.focused
              ? [
            BoxShadow(
              color: colors.primary.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: KeyboardListener(
                focusNode: FocusNode(),
                onKeyEvent: _handleKeyEvent,
                child: Opacity(
                  opacity: 0.0,
                  child: TextField(
                    controller: _controller,
                    focusNode: _internalFocusNode,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: _handleInput,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    enableInteractiveSelection: false,
                  ),
                ),
              ),
            ),
            if (_value.isNotEmpty)
              Center(
                child: Text(
                  _value,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: colors.title,
                  ),
                ),
              )
            else
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 29,
                    height: 3,
                    decoration: BoxDecoration(
                      color: colors.stroke,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OTPInputField extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;

  const OTPInputField({
    super.key,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
  });

  @override
  State<OTPInputField> createState() => OTPInputFieldState();
}

class OTPInputFieldState extends State<OTPInputField> {
  late List<FocusNode> _focusNodes;
  late List<GlobalKey<_SellioOTPInputCardState>> _cardKeys;
  final List<String> _values = [];

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _cardKeys = List.generate(
        widget.length, (index) => GlobalKey<_SellioOTPInputCardState>());
    _values.addAll(List.filled(widget.length, ''));
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleChanged(int index, String value) {
    _values[index] = value;
    final otp = _values.join();
    widget.onChanged?.call(otp);

    if (otp.length == widget.length && !otp.contains('')) {
      widget.onCompleted?.call(otp);
    }
  }

  void _handleCompleted(int index, String value) {
    // If multiple digits were pasted, fill remaining fields
    if (value.length > 1) {
      final digits = value.split('');
      for (var i = 0; i < digits.length && (index + i) < widget.length; i++) {
        _values[index + i] = digits[i];
        _cardKeys[index + i].currentState?.setValue(digits[i]);
      }

      final otp = _values.join();
      widget.onChanged?.call(otp);

      if (otp.length == widget.length && !otp.contains('')) {
        widget.onCompleted?.call(otp);
      }

      // Move focus to the next empty field after pasted digits
      final lastFilledIndex = index + digits.length - 1;
      Future.microtask(() {
        if (lastFilledIndex < widget.length - 1) {
          _focusNodes[lastFilledIndex + 1].requestFocus();
        } else {
          _focusNodes[lastFilledIndex].unfocus();
        }
      });
    }
  }

  void _handleBackspace(int index) {
    if (index > 0) {
      _values[index - 1] = '';
      _cardKeys[index - 1].currentState?.clear();

      final otp = _values.join();
      widget.onChanged?.call(otp);
    }
  }

  void clear() {
    for (var i = 0; i < widget.length; i++) {
      _values[i] = '';
      _cardKeys[i].currentState?.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.length,
            (index) => Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 0 : 8.0,
            right: index == widget.length - 1 ? 0 : 8.0,
          ),
          child: OTPInputCard(
            key: _cardKeys[index],
            focusNode: _focusNodes[index],
            nextFocusNode: index < widget.length - 1 ? _focusNodes[index + 1] : null,
            previousFocusNode: index > 0 ? _focusNodes[index - 1] : null,
            onChanged: (value) => _handleChanged(index, value),
            onCompleted: (value) => _handleCompleted(index, value),
            onBackspacePressed: () => _handleBackspace(index),
          ),
        ),
      ),
    );
  }
}