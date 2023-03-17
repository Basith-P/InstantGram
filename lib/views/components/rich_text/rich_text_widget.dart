import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'base_text.dart';
import 'link_test.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget(
      {super.key, required this.texts, this.styleForAll, this.textAlign});

  final TextStyle? styleForAll;
  final Iterable<BaseText> texts;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      text: TextSpan(
          children: texts.map(
        (baseText) {
          if (baseText is LinkText) {
            return TextSpan(
              text: baseText.text,
              style: styleForAll?.merge(baseText.style),
              recognizer: TapGestureRecognizer()
                ..onTap = () => baseText.onTap(),
            );
          } else {
            return TextSpan(
              text: baseText.text,
              style: styleForAll?.merge(baseText.style),
            );
          }
        },
      ).toList()),
    );
  }
}
