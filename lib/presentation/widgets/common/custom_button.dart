import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';

enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isExpanded;
  final double? width;
  final double? height;
  final Widget? icon;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isExpanded = false,
    this.width,
    this.height,
    this.icon,
    this.leadingIcon,
    this.trailingIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius = 12.0,
    this.padding,
    this.textStyle,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  ButtonStyle _getButtonStyle() {
    final colors = _getColors();
    final dimensions = _getDimensions();

    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return colors.backgroundColor.withOpacity(0.4);
          }
          if (states.contains(MaterialState.pressed)) {
            return colors.backgroundColor.withOpacity(0.8);
          }
          if (states.contains(MaterialState.hovered)) {
            return colors.backgroundColor.withOpacity(0.9);
          }
          return colors.backgroundColor;
        },
      ),
      foregroundColor: MaterialStateProperty.all(colors.foregroundColor),
      side: MaterialStateProperty.all(
        BorderSide(
          color: colors.borderColor,
          width: widget.variant == ButtonVariant.outline ? 2.0 : 0.0,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      padding: MaterialStateProperty.all(
        widget.padding ?? dimensions.padding,
      ),
      minimumSize: MaterialStateProperty.all(
        Size(widget.width ?? 0, widget.height ?? dimensions.height),
      ),
      elevation: MaterialStateProperty.resolveWith<double>(
        (Set<MaterialState> states) {
          if (widget.variant == ButtonVariant.outline ||
              widget.variant == ButtonVariant.ghost) {
            return 0.0;
          }
          if (states.contains(MaterialState.pressed)) {
            return 2.0;
          }
          if (states.contains(MaterialState.hovered)) {
            return 6.0;
          }
          return 4.0;
        },
      ),
      shadowColor: MaterialStateProperty.all(
        colors.backgroundColor.withOpacity(0.3),
      ),
    );
  }

  ({
    Color backgroundColor,
    Color foregroundColor,
    Color borderColor,
  }) _getColors() {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return (
          backgroundColor: widget.backgroundColor ?? AppColors.accentCoral,
          foregroundColor: widget.foregroundColor ?? AppColors.white,
          borderColor: widget.borderColor ?? AppColors.accentCoral,
        );
      case ButtonVariant.secondary:
        return (
          backgroundColor: widget.backgroundColor ?? AppColors.surfaceColor,
          foregroundColor: widget.foregroundColor ?? AppColors.primaryText,
          borderColor: widget.borderColor ?? AppColors.surfaceColor,
        );
      case ButtonVariant.outline:
        return (
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          foregroundColor: widget.foregroundColor ?? AppColors.accentCoral,
          borderColor: widget.borderColor ?? AppColors.accentCoral,
        );
      case ButtonVariant.ghost:
        return (
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          foregroundColor: widget.foregroundColor ?? AppColors.primaryText,
          borderColor: widget.borderColor ?? Colors.transparent,
        );
    }
  }

  ({
    EdgeInsetsGeometry padding,
    double height,
    double fontSize,
  }) _getDimensions() {
    switch (widget.size) {
      case ButtonSize.small:
        return (
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 36.0,
          fontSize: 14.0,
        );
      case ButtonSize.medium:
        return (
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          height: 48.0,
          fontSize: 16.0,
        );
      case ButtonSize.large:
        return (
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          height: 56.0,
          fontSize: 18.0,
        );
    }
  }

  Widget _buildButtonContent() {
    final dimensions = _getDimensions();
    final textStyle = widget.textStyle ??
        GoogleFonts.dmSans(
          fontSize: dimensions.fontSize,
          fontWeight: FontWeight.w600,
        );

    if (widget.isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            _getColors().foregroundColor,
          ),
        ),
      );
    }

    final List<Widget> children = [];

    if (widget.leadingIcon != null) {
      children.add(widget.leadingIcon!);
      children.add(const SizedBox(width: 8));
    }

    if (widget.icon != null) {
      children.add(widget.icon!);
      children.add(const SizedBox(width: 8));
    }

    children.add(
      Text(
        widget.label,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );

    if (widget.trailingIcon != null) {
      children.add(const SizedBox(width: 8));
      children.add(widget.trailingIcon!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget button = ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: _getButtonStyle(),
          child: _buildButtonContent(),
        ),
      ),
    );

    if (widget.isExpanded || widget.width != null) {
      button = SizedBox(
        width: widget.width ?? double.infinity,
        child: button,
      );
    }

    return button;
  }
}
