import 'package:flutter/material.dart';

sealed class FireBar {
  static void fireSnackBar(String s, BuildContext context,
      {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey.shade400.withOpacity(0.97),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          shape: const StadiumBorder(),
      )
    );
  }
}
