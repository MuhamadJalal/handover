import 'package:flutter/material.dart';

extension DebuggerMan on String {
  // void debug(reference){}
  void debug(reference) => debugPrint('\n\n\n ${reference?.toString().replaceAll('Instance of', '').replaceAll(' ', '')}: $this \n\n\n', wrapWidth: 800);
}
