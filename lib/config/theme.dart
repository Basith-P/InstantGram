import 'package:flutter/material.dart';

class AppTheme {
  //dark and light themes
  static get darkTheme => ThemeData.dark().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
          elevation: 0,
          centerTitle: true,
        ),

        // progress indicator color black strok 2
        progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.black, linearTrackColor: Colors.black12),
      );

  static final lightTheme = ThemeData.light(useMaterial3: true);
}
