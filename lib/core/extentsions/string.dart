
extension StringExt on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  bool get hasNumbers {
    RegExp numbers = RegExp(r'[0-9]');
    return numbers.hasMatch(this);
  }

  bool get hasLetters {
    RegExp letters = RegExp(r'[a-zA-Z]');
    return letters.hasMatch(this);
  }

  String slugify() {
    return replaceAll(RegExp(r'[^\w\s-]'), '')
        .trim()
        .replaceAll(' ', '-')
        .toLowerCase()
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

  String capitalize() {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }


}
