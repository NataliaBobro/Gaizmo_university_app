import 'package:flutter/services.dart';

class EmojiInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Regular expression, which includes the majority emoji
    final regExp = RegExp(
        '[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F700}-\u{1F77F}'
        '\u{1F780}-\u{1F7FF}\u{1F800}-\u{1F8FF}\u{1F900}-\u{1F9FF}\u{2600}-\u{26FF}'
        '\u{2700}-\u{27BF}\u{1F900}-\u{1F9FF}\u{1F1E6}-\u{1F1FF}]',
        unicode: true);

    // Определяем новую позицию курсора
    int offset = newValue.selection.baseOffset;
    String newText = newValue.text.replaceAll(regExp, '');

    // Проверяем, не вышла ли позиция курсора за пределы новой длины текста
    if (offset > newText.length) {
      offset = newText.length;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

class NonAsianInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Regular expression for hieroglyphs
    final regExp = RegExp(
        '[\u3400-\u4DBF\u4E00-\u9FFF\uF900-\uFAFF\u3040-\u309F\u30A0-\u30FF\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F]');

    // Определяем новую позицию курсора
    int offset = newValue.selection.baseOffset;
    String newText = newValue.text.replaceAll(regExp, '');

    // Проверяем, не вышла ли позиция курсора за пределы новой длины текста
    if (offset > newText.length) {
      offset = newText.length;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Regular expression for hieroglyphs
    final regExp = RegExp(r'[~`!#$%\^&\*\(\)\\|\[\]{}:",<>\?]');

    // Определяем новую позицию курсора
    int offset = newValue.selection.baseOffset;
    String newText = newValue.text.replaceAll(regExp, '').replaceAll(' ', '');

    // Проверяем, не вышла ли позиция курсора за пределы новой длины текста
    if (offset > newText.length) {
      offset = newText.length;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

class NameInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'[^a-zA-Zа-яА-ЯёЁ\- \.]');

    // Определяем новую позицию курсора
    int offset = newValue.selection.baseOffset;
    String newText = newValue.text.replaceAll(regExp, '');
    newText = newValue.text.replaceAll("  ", " ");
    newText = capitalizeEachWord(newText);
    if(oldValue.text.isEmpty){
      newText = newText.trim();
    }

    // Проверяем, не вышла ли позиция курсора за пределы новой длины текста
    if (offset > newText.length) {
      offset = newText.length;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

String capitalizeEachWord(String text) {
  if (text.isEmpty) return text;
  return text.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}
