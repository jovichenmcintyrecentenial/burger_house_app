extension StringExtensions on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isNumeric() {
    return (double.tryParse(this) != null || int.tryParse(this) != null);
  }

  double? toDouble() {
    return double.tryParse(this);
  }

  String capitalize() {
    if(length > 1) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }
    return this;
  }
}