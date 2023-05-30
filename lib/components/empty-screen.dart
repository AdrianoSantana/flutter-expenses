import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String message;
  const EmptyScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Pangolin',
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 200,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
