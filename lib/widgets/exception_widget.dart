import 'package:flutter/material.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({super.key, required this.message, required this.icon});
  final String message;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(108, 255, 255, 255),
            size: 40,
          ),
          Text(
            textAlign: TextAlign.center,
            message,
            style: const TextStyle(
              color: Color.fromARGB(108, 255, 255, 255),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}