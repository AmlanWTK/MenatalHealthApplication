import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SlideFadeInOnVisible extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset offset;
  final Curve curve;
  final Key visibilityKey;

  const SlideFadeInOnVisible({
    super.key,
    required this.child,
    required this.duration,
    required this.offset,
    required this.curve,
    required this.visibilityKey,
  });

  @override
  State<SlideFadeInOnVisible> createState() => _SlideFadeInOnVisibleState();
}

class _SlideFadeInOnVisibleState extends State<SlideFadeInOnVisible> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.visibilityKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0, // Fade in
        duration: widget.duration,
        curve: widget.curve,
        child: AnimatedSlide(
          offset: _isVisible ? Offset.zero : widget.offset, // Slide in
          duration: widget.duration,
          curve: widget.curve,
          child: widget.child,
        ),
      ),
    );
  }
}
