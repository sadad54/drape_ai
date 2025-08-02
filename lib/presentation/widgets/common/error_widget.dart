// Error widget
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String message;
  const ErrorWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message, style: TextStyle(color: Colors.red)));
  }
}
