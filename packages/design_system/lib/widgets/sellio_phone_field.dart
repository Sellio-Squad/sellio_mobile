import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_intl_phone_field/countries.dart' as intl_countries;
import 'package:flutter_svg/svg.dart';
import '../constants/app_images.dart';
import '../themes/sellio_theme_provider.dart';

class SellioPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Country? selectedCountry;
  final ValueChanged<Country> onCountrySelected;
  final String hintText;
  final String defaultCountryCode;
  final List<String> favoriteCountries;
  final String searchHintText;

  const SellioPhoneField({
    super.key,
    required this.controller,
    this.focusNode,
    this.selectedCountry,
    required this.onCountrySelected,
    this.hintText = 'Phone number',
    this.defaultCountryCode = 'IQ',
    this.favoriteCountries = const ['IQ', 'EG', 'PS', 'SY'],
    this.searchHintText = 'Search by name or code',
  });

  @override
  State<SellioPhoneField> createState() => _SellioPhoneFieldState();
}

class _SellioPhoneFieldState extends State<SellioPhoneField> {
  late final FocusNode _effectiveFocusNode;
  bool _ownsNode = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      _effectiveFocusNode = widget.focusNode!;
    } else {
      _effectiveFocusNode = FocusNode();
      _ownsNode = true;
    }
    _effectiveFocusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_onTextChange);
    if (_ownsNode) {
      _effectiveFocusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() => setState(() {});

  void _onTextChange() => setState(() {});

  int _getMaxLength() {
    final countryCode =
        widget.selectedCountry?.countryCode.toUpperCase() ??
        widget.defaultCountryCode.toUpperCase();

    try {
      final country = intl_countries.countries.firstWhere(
        (c) => c.code.toUpperCase() == countryCode,
        orElse: () => intl_countries.countries.firstWhere(
          (c) => c.code == widget.defaultCountryCode,
        ),
      );
      return country.maxLength;
    } catch (_) {
      return 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    final maxLength = _getMaxLength();
    final textLength = widget.controller.text.length;
    final isFocused = _effectiveFocusNode.hasFocus;
    final isValid = textLength == maxLength;
    final isError = textLength > maxLength;
    final showCounter = widget.controller.text.isNotEmpty && !isValid;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildInputContainer(colors, textTheme, maxLength, isFocused),
        if (showCounter)
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 4),
            child: Text(
              '$textLength/$maxLength',
              style: textTheme.labelSmall.copyWith(
                color: isError ? colors.red : colors.body,
                fontWeight: isError ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInputContainer(
    dynamic colors,
    dynamic textTheme,
    int maxLength,
    bool isFocused,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                  color: colors.primary.withValues(alpha: 0.12),
                ),
              ]
            : [],
        border: Border.all(
          color: isFocused ? colors.primary : colors.stroke,
          width: isFocused ? 1.0 : 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child: SvgPicture.asset(AppImages.phone, width: 24, height: 24),
          ),
          _buildCountrySelector(colors, textTheme),
          Expanded(child: _buildPhoneTextField(colors, textTheme, maxLength)),
        ],
      ),
    );
  }

  Widget _buildCountrySelector(dynamic colors, dynamic textTheme) {
    return GestureDetector(
      onTap: () => _showCountryPicker(colors, textTheme),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImages.arrowDown, width: 20, height: 20),
            const Gap(4),
            CountryFlag.fromCountryCode(
              widget.selectedCountry?.countryCode ?? widget.defaultCountryCode,
              shape: const Circle(),
              width: 20,
              height: 20,
            ),
            const Gap(4),
            Text(
              ' +${widget.selectedCountry?.phoneCode ?? '20'}',
              style: textTheme.bodyMedium.copyWith(color: colors.title),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneTextField(
    dynamic colors,
    dynamic textTheme,
    int maxLength,
  ) {
    return TextField(
      cursorColor: colors.primary,
      cursorHeight: 20,
      controller: widget.controller,
      focusNode: _effectiveFocusNode,
      style: textTheme.bodyMedium.copyWith(color: colors.title),
      enabled: true,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.startsWith('0')) {
            return oldValue;
          }
          return newValue;
        }),
      ],
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: textTheme.labelMedium.copyWith(color: colors.body),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }

  void _showCountryPicker(dynamic colors, dynamic textTheme) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: widget.onCountrySelected,
      favorite: widget.favoriteCountries,
      countryListTheme: CountryListThemeData(
        flagSize: 20,
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.8,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        inputDecoration: InputDecoration(
          hintText: widget.searchHintText,
          focusColor: colors.primary,
          hintStyle: textTheme.labelMedium.copyWith(color: colors.body),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AppImages.search, width: 16, height: 16),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
