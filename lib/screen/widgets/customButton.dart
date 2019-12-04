import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  bool _recorder = false;
  bool _hasText = false;
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buttonControl(),
    );
  }

  Widget buttonControl(){

  }

  
}