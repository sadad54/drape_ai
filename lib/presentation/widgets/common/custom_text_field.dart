import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';

enum TextFieldVariant {
  filled,
  outlined,
  underlined,
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final Widget? suffixWidget;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final InputDecoration? decoration;
  final TextFieldVariant variant;
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool showCharacterCount;
  final bool autofocus;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hint,
    this.label,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
    this.suffixWidget,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.validator,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.decoration,
    this.variant = TextFieldVariant.filled,
    this.borderRadius = 12.0,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.contentPadding,
    this.showCharacterCount = false,
    this.autofocus = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _animationController;
  late Animation<Color?> _borderColorAnimation;
  late Animation<double> _labelScaleAnimation;

  bool get _hasError => widget.errorText != null;
  bool get _isFocused => _focusNode.hasFocus;
  bool get _hasText => widget.controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _borderColorAnimation = ColorTween(
      begin: widget.borderColor ?? AppColors.overlay20,
      end: widget.focusedBorderColor ?? AppColors.accentCoral,
    ).animate(_animationController);

    _labelScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(_animationController);

    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {});
  }

  void _onTextChange() {
    setState(() {});
  }

  InputDecoration _buildDecoration() {
    final baseDecoration = InputDecoration(
      hintText: widget.hint,
      labelText: widget.label,
      helperText: widget.helperText,
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon != null
          ? Icon(
              widget.prefixIcon,
              color: _hasError
                  ? AppColors.error
                  : _isFocused
                      ? AppColors.accentCoral
                      : AppColors.secondaryText,
              size: 20,
            )
          : null,
      prefix: widget.prefixWidget,
      suffixIcon: widget.suffixIcon,
      suffix: widget.suffixWidget,
      counterText: widget.showCharacterCount ? null : '',
      contentPadding: widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      // Styling
      hintStyle: GoogleFonts.dmSans(
        color: AppColors.disabledText,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: GoogleFonts.dmSans(
        color: _hasError
            ? AppColors.error
            : _isFocused
                ? AppColors.accentCoral
                : AppColors.secondaryText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      helperStyle: GoogleFonts.dmSans(
        color: AppColors.secondaryText,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.dmSans(
        color: AppColors.error,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );

    switch (widget.variant) {
      case TextFieldVariant.filled:
        return baseDecoration.copyWith(
          filled: true,
          fillColor:
              widget.fillColor ?? AppColors.surfaceColor.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? AppColors.accentCoral,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? AppColors.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? AppColors.error,
              width: 2,
            ),
          ),
        );

      case TextFieldVariant.outlined:
        return baseDecoration.copyWith(
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.overlay20,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.overlay20,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? AppColors.accentCoral,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? AppColors.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? AppColors.error,
              width: 2,
            ),
          ),
        );

      case TextFieldVariant.underlined:
        return baseDecoration.copyWith(
          filled: false,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.overlay20,
              width: 1,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.overlay20,
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? AppColors.accentCoral,
              width: 2,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? AppColors.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? AppColors.error,
              width: 2,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              inputFormatters: widget.inputFormatters,
              validator: widget.validator,
              onTap: widget.onTap,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onSubmitted,
              onEditingComplete: widget.onEditingComplete,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              textCapitalization: widget.textCapitalization,
              textAlign: widget.textAlign,
              autofocus: widget.autofocus,
              style: widget.textStyle ??
                  GoogleFonts.dmSans(
                    color: AppColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
              decoration: widget.decoration ?? _buildDecoration(),
            ),
          ],
        );
      },
    );
  }
}
