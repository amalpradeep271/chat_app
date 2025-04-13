// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AuthPrompt extends StatelessWidget {
  final String text1;
  final String text2;

  final VoidCallback onTap;
  const AuthPrompt({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: text1,
            style: TextStyle(color: Colors.grey),
            children: [
              TextSpan(text: text2, style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
