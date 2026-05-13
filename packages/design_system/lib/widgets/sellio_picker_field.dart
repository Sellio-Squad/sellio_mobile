import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SellioPickerField<T> extends StatefulWidget {
  final String hintText;
  final T? value;
  final List<SellioPickerItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry prefixIconPadding;
  final String? errorText;
  final Widget Function(T)? itemBuilder;
  final String? emptyMessage;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final double dropdownMaxHeight;

  const SellioPickerField({
    super.key,
    required this.hintText,
    this.value,
    required this.items,
    this.onChanged,
    this.prefixIcon,
    this.prefixIconPadding = const EdgeInsets.only(left: 16, right: 8),
    this.errorText,
    this.itemBuilder,
    this.emptyMessage,
    this.suffixIcon,
    this.focusNode,
    this.dropdownMaxHeight = 200,
  });

  @override
  State<SellioPickerField<T>> createState() => _SellioPickerFieldState<T>();
}

class _SellioPickerFieldState<T> extends State<SellioPickerField<T>> {
  final TextEditingController _displayController = TextEditingController();
  late FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _updateDisplayValue();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  @override
  void didUpdateWidget(covariant SellioPickerField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value || widget.items != oldWidget.items) {
      _updateDisplayValue();
    }
  }

  void _updateDisplayValue() {
    if (widget.value == null) {
      _displayController.clear();
    } else {
      final item = widget.items.firstWhereOrNull(
        (item) => item.value == widget.value,
      );
      if (item != null) {
        _displayController.text = item.label;
      } else {
        _displayController.clear();
      }
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 4,
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 4),
            child: _buildDropdownMenu(context),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildDropdownMenu(BuildContext context) {
    final colors = context.theme.colors;

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      color: colors.surface,
      child: Container(
        constraints: BoxConstraints(maxHeight: widget.dropdownMaxHeight),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.stroke, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: widget.items.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.emptyMessage ?? 'No items found',
                  style: context.theme.typography.textTheme.bodyMedium.copyWith(
                    color: colors.body,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(4),
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final isSelected = item.value == widget.value;

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        widget.onChanged?.call(item.value);
                        _focusNode.unfocus();
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: isSelected
                              ? colors.primary.withValues(alpha: 0.1)
                              : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            if (isSelected)
                              Icon(Icons.check, size: 16, color: colors.primary)
                            else
                              const SizedBox(width: 16),
                            Expanded(
                              child:
                                  widget.itemBuilder?.call(item.value) ??
                                  Text(
                                    item.label,
                                    style: context
                                        .theme
                                        .typography
                                        .textTheme
                                        .bodyMedium
                                        .copyWith(
                                          color: isSelected
                                              ? colors.primary
                                              : colors.title,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    _displayController.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _toggleFocus() {
    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return CompositedTransformTarget(
      link: _layerLink,
      child: Focus(
        focusNode: _focusNode,
        canRequestFocus: true,
        child: SellioTextField(
          controller: _displayController,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          prefixIconPadding: widget.prefixIconPadding,
          readOnly: true,
          suffixIcon:
              widget.suffixIcon ??
              Icon(Icons.arrow_drop_down, color: colors.body),
          onTap: _toggleFocus,
        ),
      ),
    );
  }
}

class SellioPickerItem<T> {
  final T value;
  final String label;

  const SellioPickerItem(this.value, this.label);
}

extension _FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
