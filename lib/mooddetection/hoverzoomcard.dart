import 'package:flutter/material.dart';

class Hoverzoomcard extends StatefulWidget {
  final Widget child;
  const Hoverzoomcard({
    super.key,
    required this.child
    
    });

  @override
  State<Hoverzoomcard> createState() => _HoverzoomcardState();
}

class _HoverzoomcardState extends State<Hoverzoomcard> {
  bool _isHovered=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        //called when mouse enters the widget area
        onEnter: (_){
          setState(() {
            _isHovered=true;
          });
        },
        //called when mouse leaves the widget area
        onExit: (_){
          setState(() {
            _isHovered=false;
          });
        },
        child: AnimatedScale(
          scale: _isHovered?1.05:1.0, 
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Material(
            //elevation changeto create the shadow effect
            elevation: _isHovered?12:4,
            borderRadius: BorderRadius.circular(20),
            child: widget.child,
          ),
          ),
      ),
    );
  }
}