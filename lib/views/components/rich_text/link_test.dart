import 'package:flutter/foundation.dart' show immutable, VoidCallback;

import 'base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTap;

  const LinkText({
    required super.text,
    required this.onTap,
    super.style,
  });
}
