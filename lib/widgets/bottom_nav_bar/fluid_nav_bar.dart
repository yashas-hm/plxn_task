import 'package:flutter/material.dart';
import 'package:plxn_task/widgets/bottom_nav_bar/curves.dart';
import 'package:plxn_task/widgets/bottom_nav_bar/fluid_nav_bar_icon.dart';
import 'package:plxn_task/widgets/bottom_nav_bar/fluid_nav_bar_item.dart';
import 'package:plxn_task/widgets/bottom_nav_bar/fluid_nav_bar_style.dart';

typedef FluidNavBarChangeCallback = void Function(int selectedIndex);

typedef FluidNavBarItemBuilder = Widget Function(
    FluidNavBarIcon icon, FluidNavBarItem item);

class FluidNavBar extends StatefulWidget {
  final double nominalHeight;

  final List<FluidNavBarIcon> icons;

  final FluidNavBarChangeCallback? onChange;

  final FluidNavBarStyle? style;

  final double animationFactor;

  final double scaleFactor;

  final int defaultIndex;

  final FluidNavBarItemBuilder itemBuilder;

  const FluidNavBar({
    Key? key,
    required this.icons,
    this.onChange,
    this.style,
    this.animationFactor = 1.0,
    this.scaleFactor = 1.2,
    this.defaultIndex = 0,
    this.nominalHeight = 60,
    FluidNavBarItemBuilder? itemBuilder,
  })  : itemBuilder = itemBuilder ?? _identityBuilder,
        assert(icons.length > 1),
        super(key: key);

  @override
  State createState() => _FluidNavBarState();

  static Widget _identityBuilder(FluidNavBarIcon icon, FluidNavBarItem item) =>
      item;
}

class _FluidNavBarState extends State<FluidNavBar>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  late final AnimationController _xController;
  late final AnimationController _yController;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.defaultIndex;

    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    _xController.value =
        _indexToPosition(_currentIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final appSize = MediaQuery.of(context).size;

    return SizedBox(
      width: appSize.width,
      height: widget.nominalHeight,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: appSize.width,
            height: widget.nominalHeight,
            child: _buildBackground(),
          ),
          Positioned(
            left: (appSize.width - _getButtonContainerWidth()) / 2,
            top: 0,
            width: _getButtonContainerWidth(),
            height: widget.nominalHeight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildButtons()),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return CustomPaint(
      painter: _BackgroundCurvePainter(
        _xController.value * MediaQuery.of(context).size.width,
        Tween<double>(
          begin: Curves.easeInExpo.transform(_yController.value),
          end: const ElasticOutCurve(0.38).transform(_yController.value),
        ).transform(_yController.velocity.sign * 0.5 + 0.5),
        widget.style?.barBackgroundColor ?? Colors.white,
      ),
    );
  }

  List<Widget> _buildButtons() {
    return widget.icons
        .asMap()
        .entries
        .map(
          (entry) => widget.itemBuilder(
            entry.value,
            FluidNavBarItem(
              entry.value.svgPath ?? entry.value.svgPath,
              entry.value.icon,
              _currentIndex == entry.key,
              () => _handleTap(entry.key),
              entry.value.selectedForegroundColor ??
                  widget.style?.iconSelectedForegroundColor ??
                  Colors.black,
              entry.value.unselectedForegroundColor ??
                  widget.style?.iconUnselectedForegroundColor ??
                  Colors.grey,
              entry.value.backgroundColor ??
                  widget.style?.iconBackgroundColor ??
                  widget.style?.barBackgroundColor ??
                  Colors.white,
              widget.scaleFactor,
              widget.animationFactor,
              image: entry.value.image,
            ),
          ),
        )
        .toList();
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  double _indexToPosition(int index) {
    var buttonCount = widget.icons.length;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX +
        index.toDouble() * buttonsWidth / buttonCount +
        buttonsWidth / (buttonCount * 2.0);
  }

  void _handleTap(int index) {
    if (_currentIndex == index || _xController.isAnimating) return;

    setState(() {
      _currentIndex = index;
    });

    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 620) * widget.animationFactor);
    Future.delayed(
      const Duration(milliseconds: 500) * widget.animationFactor,
      () {
        _yController.animateTo(1.0,
            duration:
                const Duration(milliseconds: 1200) * widget.animationFactor);
      },
    );
    _yController.animateTo(0.0,
        duration: const Duration(milliseconds: 300) * widget.animationFactor);

    if (widget.onChange != null) {
      widget.onChange!(index);
    }
  }
}

class _BackgroundCurvePainter extends CustomPainter {
  static const _radiusTop = 54.0;
  static const _radiusBottom = 44.0;
  static const _horizontalControlTop = 0.6;
  static const _horizontalControlBottom = 0.5;
  static const _pointControlTop = 0.35;
  static const _pointControlBottom = 0.85;
  static const _topY = -10.0;
  static const _bottomY = 54.0;
  static const _topDistance = 0.0;
  static const _bottomDistance = 6.0;

  final double _x;
  final double _normalizedY;
  final Color _color;

  _BackgroundCurvePainter(double x, double normalizedY, Color color)
      : _x = x,
        _normalizedY = normalizedY,
        _color = color;

  @override
  void paint(canvas, size) {

    final norm = const LinearPointCurve(0.5, 2.0).transform(_normalizedY) / 2;

    final radius =
        Tween<double>(begin: _radiusTop, end: _radiusBottom).transform(norm);

    final anchorControlOffset = Tween<double>(
            begin: radius * _horizontalControlTop,
            end: radius * _horizontalControlBottom)
        .transform(const LinearPointCurve(0.5, 0.75).transform(norm));

    final dipControlOffset = Tween<double>(
            begin: radius * _pointControlTop, end: radius * _pointControlBottom)
        .transform(const LinearPointCurve(0.5, 0.8).transform(norm));

    final y = Tween<double>(begin: _topY, end: _bottomY)
        .transform(const LinearPointCurve(0.2, 0.7).transform(norm));

    final dist = Tween<double>(begin: _topDistance, end: _bottomDistance)
        .transform(const LinearPointCurve(0.5, 0.0).transform(norm));

    final x0 = _x - dist / 2;

    final x1 = _x + dist / 2;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(x0 - radius, 0)
      ..cubicTo(
          x0 - radius + anchorControlOffset, 0, x0 - dipControlOffset, y, x0, y)
      ..lineTo(x1, y)
      ..cubicTo(x1 + dipControlOffset, y, x1 + radius - anchorControlOffset, 0,
          x1 + radius, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    final paint = Paint()..color = _color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BackgroundCurvePainter oldPainter) {
    return _x != oldPainter._x ||
        _normalizedY != oldPainter._normalizedY ||
        _color != oldPainter._color;
  }
}