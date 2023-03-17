import 'package:flutter/material.dart'
    show immutable, TextStyle, Colors, TextDecoration, VoidCallback;
import 'package:instant_gram/views/components/rich_text/link_test.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({required this.text, this.style});

  factory BaseText.plain({required String text, TextStyle? style}) =>
      BaseText(text: text, style: style ?? TextStyle());

  factory BaseText.link(
          {required String text,
          required VoidCallback onTap,
          TextStyle? style = const TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
          )}) =>
      LinkText(text: text, style: style, onTap: onTap);
}
