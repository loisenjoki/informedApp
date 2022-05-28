import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class Styles  {
  static TextStyle header() {
    return const TextStyle(
      color: Colors.black87,
      fontSize: 16,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle caption() {
    return const TextStyle(
        color: Colors.black54,
        fontSize: 12
    );
  }

  static TextStyle title() {
    return const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 16
    );
  }

  static TextStyle medium() {
    return const TextStyle(
        color: Colors.grey,
        fontSize: 14
    );
  }
  static TextStyle small() {
    return const TextStyle(
        color: Colors.grey,
        fontSize: 12
    );
  }
}