class TooltipHandler {
  static String showCustomTooltip(
      {required String? value, required String defaultValue}) {
    if (value == null) return defaultValue;

    if (value.length > 15) {
      return "${value.substring(0, 15)}...";
    }

    return value;
  }
}
