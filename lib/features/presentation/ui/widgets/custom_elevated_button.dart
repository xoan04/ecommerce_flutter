import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final TextStyle textStyle;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.backgroundColor = Colors.deepPurpleAccent,
    this.foregroundColor = Colors.white,
    
    this.padding = const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    this.borderRadius = 30.0,
    this.textStyle = const TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    required this.onPressed, 
    
    
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor:foregroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: textStyle,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
