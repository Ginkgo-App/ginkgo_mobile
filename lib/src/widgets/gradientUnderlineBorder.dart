part of 'widgets.dart';
/// Based on [OutlineInputBorder]
class GradientUnderlineInputBorder extends InputBorder {
  final Gradient focusedGradient;
  final Gradient unfocusedGradient;

  const GradientUnderlineInputBorder({
    BorderSide borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.gapPadding = 4.0,
    @required this.focusedGradient,
    this.unfocusedGradient,
  })  : assert(borderRadius != null),
        assert(gapPadding != null && gapPadding >= 0.0),
        super(borderSide: borderSide);

  static bool _cornersAreCircular(BorderRadius borderRadius) {
    return borderRadius.topLeft.x == borderRadius.topLeft.y &&
        borderRadius.bottomLeft.x == borderRadius.bottomLeft.y &&
        borderRadius.topRight.x == borderRadius.topRight.y &&
        borderRadius.bottomRight.x == borderRadius.bottomRight.y;
  }

  final double gapPadding;

  final BorderRadius borderRadius;

  @override
  bool get isOutline => false;

  @override
  GradientUnderlineInputBorder copyWith({
    BorderSide borderSide,
    BorderRadius borderRadius,
    double gapPadding,
  }) {
    return GradientUnderlineInputBorder(
        borderSide: borderSide ?? this.borderSide,
        borderRadius: borderRadius ?? this.borderRadius,
        gapPadding: gapPadding ?? this.gapPadding,
        focusedGradient: this.focusedGradient,
        unfocusedGradient: this.unfocusedGradient);
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(borderSide.width);
  }

  @override
  GradientUnderlineInputBorder scale(double t) {
    return GradientUnderlineInputBorder(
        borderSide: borderSide.scale(t),
        borderRadius: borderRadius * t,
        gapPadding: gapPadding * t,
        focusedGradient: this.focusedGradient,
        unfocusedGradient: this.unfocusedGradient);
  }

  @override
  ShapeBorder lerpFrom(ShapeBorder a, double t) {
    if (a is GradientUnderlineInputBorder) {
      final GradientUnderlineInputBorder outline = a;
      return GradientUnderlineInputBorder(
          borderRadius:
              BorderRadius.lerp(outline.borderRadius, borderRadius, t),
          borderSide: BorderSide.lerp(outline.borderSide, borderSide, t),
          gapPadding: outline.gapPadding,
          focusedGradient: this.focusedGradient,
          unfocusedGradient: this.unfocusedGradient);
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder lerpTo(ShapeBorder b, double t) {
    if (b is GradientUnderlineInputBorder) {
      final GradientUnderlineInputBorder outline = b;
      return GradientUnderlineInputBorder(
          borderRadius:
              BorderRadius.lerp(borderRadius, outline.borderRadius, t),
          borderSide: BorderSide.lerp(borderSide, outline.borderSide, t),
          gapPadding: outline.gapPadding,
          focusedGradient: this.focusedGradient,
          unfocusedGradient: this.unfocusedGradient);
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..addRRect(borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(borderSide.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  Path _gapBorderPath(
      Canvas canvas, RRect center, double start, double extent) {
    return Path()
      ..moveTo(center.right, center.bottom)
      ..lineTo(center.left, center.bottom);
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
    assert(gapExtent != null);
    assert(gapPercentage >= 0.0 && gapPercentage <= 1.0);
    assert(_cornersAreCircular(borderRadius));

    final RRect outer = borderRadius.toRRect(rect);
    final Paint paint = borderSide.toPaint();

    final bool isFocused = borderSide.width > 1.0;

    paint.shader = isFocused
        ? focusedGradient.createShader(outer.outerRect)
        : unfocusedGradient?.createShader(outer.outerRect);

    final RRect center = outer.deflate(borderSide.width / 2.0);
    if (gapStart == null || gapExtent <= 0.0 || gapPercentage == 0.0) {
      canvas.drawPath(
          _gapBorderPath(canvas, center, gapStart + gapPadding, 0), paint);
    } else {
      final double extent =
          lerpDouble(0.0, gapExtent + gapPadding * 2.0, gapPercentage);
      switch (textDirection) {
        case TextDirection.rtl:
          {
            final Path path = _gapBorderPath(
                canvas, center, gapStart + gapPadding - extent, extent);
            canvas.drawPath(path, paint);
            break;
          }
        case TextDirection.ltr:
          {
            final Path path =
                _gapBorderPath(canvas, center, gapStart - gapPadding, extent);
            canvas.drawPath(path, paint);
            break;
          }
      }
    }
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final GradientUnderlineInputBorder typedOther = other;
    return typedOther.borderSide == borderSide &&
        typedOther.borderRadius == borderRadius &&
        typedOther.gapPadding == gapPadding;
  }

  @override
  int get hashCode => hashValues(borderSide, borderRadius, gapPadding);
}
