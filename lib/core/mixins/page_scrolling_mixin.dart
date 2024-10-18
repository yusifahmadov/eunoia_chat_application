// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';

/// A mixin that provides functionality for handling page scrolling.
/// It includes a [ScrollController] to manage the scroll position and
/// a mechanism to detect when the user has scrolled to the end of the page.
mixin PageScrollingMixin {
  // ScrollController to manage and listen to scroll events.
  ScrollController _scrollController = ScrollController();

  // Getter for the ScrollController.
  ScrollController get scrollController => _scrollController;

  // A function that will be called to initialize or load more data.
  late Future<void> Function() _initFunction;

  // Getter for the initialization function.
  Future<void> Function() get initFunction => _initFunction;

  // Setter for the initialization function.
  set initFunction(Future<void> Function() value) => _initFunction = value;

  // Setter for the ScrollController.
  set scrollController(ScrollController value) => _scrollController = value;

  // Boolean to check if the scrolling is for a table.
  late bool _isTable;

  // A dynamic cubit object, typically used for state management.
  dynamic _cubit;

  /// Initializes the scrolling functionality.
  ///
  /// [isTable] - A boolean indicating if the scrolling is for a table.
  /// [cubit] - A dynamic object for state management.
  /// [function] - A function to initialize or load more data.
  /// [callInFirstTime] - A boolean indicating if the function should be called immediately.
  Future<void> initializeScrolling({
    required Future<void> Function() function,
    bool isTable = false,
    dynamic cubit,
    bool callInFirstTime = true,
  }) async {
    initFunction = function;
    _isTable = isTable;
    _cubit = cubit;
    if (callInFirstTime) await initFunction();

    scrollController.addListener(detectScrolledToEnd);
  }

  /// Detaches the scroll listener and disposes of the ScrollController.
  void detachListener({bool dispose = true}) {
    scrollController.removeListener(detectScrolledToEnd);
    if (dispose) scrollController.dispose();
  }

  /// Detects if the user has scrolled to the end of the page.
  /// If the user has scrolled to the end, it calls the initialization function
  /// to load more data.
  Future<void> detectScrolledToEnd() async {
    if (_isTable) {
      if (scrollController.position.pixels > scrollController.position.maxScrollExtent &&
          (_cubit == null || (_cubit.isLoading as bool) == false)) {
        await initFunction();
        return;
      }
    }
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
        (_cubit == null || (_cubit.isLoading as bool) == false)) {
      await initFunction();
    }
  }
}
