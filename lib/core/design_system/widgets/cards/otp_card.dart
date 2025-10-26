import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_colors.dart';

enum OTPInputState { defaultState, focused, filled }

class OTPInputCard extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  const OTPInputCard({
    Key? key,
    this.onChanged,
    this.onCompleted,
    this.focusNode,
    this.nextFocusNode,
  }) : super(key: key);

  @override
  State<OTPInputCard> createState() => _OTPInputCardState();
}

class _OTPInputCardState extends State<OTPInputCard> {
  OTPInputState _currentState = OTPInputState.defaultState;
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
        _currentState = OTPInputState.focused;
      } else {
        if (_value.isEmpty) {
          _currentState = OTPInputState.defaultState;
        } else {
          _currentState = OTPInputState.filled;
        }
      }
    });
  }

  void _handleInput(String value) {
    if (value.isNotEmpty && RegExp(r'^[0-9]$').hasMatch(value)) {
      setState(() {
        _value = value;
        _currentState = OTPInputState.filled;
      });
      widget.onChanged?.call(value);
      widget.onCompleted?.call(value);
      if (widget.nextFocusNode != null) {
        widget.nextFocusNode!.requestFocus();
      } else {
        _internalFocusNode.unfocus();
      }
    }
  }

  Color _getBorderColor(BuildContext context) {
    final colors = Theme.of(context).extension<SellioColorScheme>() ?? SellioColors.light;

    switch (_currentState) {
      case OTPInputState.focused:
        return colors.primary;
      case OTPInputState.defaultState:
      case OTPInputState.filled:
        return colors.stroke;
    }
  }

  double _getBorderWidth() {
    return _currentState == OTPInputState.focused ? 1.0 : 0.5;
  }

  Color _getBackgroundColor(BuildContext context) {
    final colors = Theme.of(context).extension<SellioColorScheme>() ?? SellioColors.light;

    return _currentState == OTPInputState.focused
        ? colors.surfaceLow
        : colors.surface;
  }

  void clear() {
    setState(() {
      _value = '';
      _controller.clear();
      _currentState = OTPInputState.defaultState;
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
          boxShadow: _currentState == OTPInputState.focused
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
              child: Opacity(
                opacity: 0.0,
                child: TextField(
                  controller: _controller,
                  focusNode: _internalFocusNode,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: _handleInput,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
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
              ),
            if (_value.isEmpty)
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
    Key? key,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
  }) : super(key: key);

  @override
  State<OTPInputField> createState() => OTPInputFieldState();
}

class OTPInputFieldState extends State<OTPInputField> {
  late List<FocusNode> _focusNodes;
  late List<GlobalKey<_OTPInputCardState>> _cardKeys;
  final List<String> _values = [];

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _cardKeys = List.generate(widget.length, (index) => GlobalKey<_OTPInputCardState>());
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

    if (otp.length == widget.length) {
      widget.onCompleted?.call(otp);
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
            onChanged: (value) => _handleChanged(index, value),
          ),
        ),
      ),
    );
  }
}