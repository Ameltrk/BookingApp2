import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final Color color;
  final double top;
  final double left;

  const BackButtonWidget({
    super.key,
    this.color = Colors.white,
    this.top = 40,
    this.left = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(Icons.arrow_back, color: color, size: 30),
        ),
      ),
    );
  }
}
