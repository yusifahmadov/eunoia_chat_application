import 'package:eunoia_chat_application/core/debouncer.dart';

/// A mixin that provides debouncing functionality for search operations.
///
/// This mixin uses a [Debouncer] to delay the execution of a search function
/// by a specified duration. It helps in reducing the number of search
/// operations triggered by user input, especially in scenarios where the
/// input changes rapidly (e.g., typing in a search bar).
///
/// Usage:
/// ```dart
/// class MySearchClass with DebouncerSearchMixin {
///   void onSearchChanged() {
///     search(onChanged: () async {
///       // Perform search operation here
///     });
///   }
/// }
/// ```
///
/// The [search] method takes a required onChanged callback, which is the
/// function to be executed after the debounce delay.
///
/// The debounce delay is set to 500 milliseconds by default.

mixin DebouncerSearchMixin {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  void search({required Future<void> Function() onChanged}) {
    _debouncer.run(() async {
      await onChanged();
    });
  }
}
