import 'dart:async';

import 'package:flutter/material.dart';

/// The `Debouncer` class helps to delay the execution of a function
/// by a specified duration. This is useful in scenarios where you
/// want to limit the rate at which a function is called, such as
/// handling user input events like typing or scrolling.
///
/// The `Debouncer` takes a `Duration` as a delay and provides a
/// `run` method to execute the desired action after the delay.
/// If `run` is called again before the delay has passed, the
/// previous timer is canceled and a new one is started.
class Debouncer {
  Debouncer({required this.delay});
  final Duration delay;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
