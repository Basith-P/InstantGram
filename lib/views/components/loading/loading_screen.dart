import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instant_gram/views/components/loading/loading_screen_controller.dart';

import '../../../state/constants/widgets.dart';
import '../constants/strings.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();

  static final LoadingScreen _instance = LoadingScreen._sharedInstance();

  factory LoadingScreen.instance() => _instance;

  LoadingScreenController? _controller;

  void show(BuildContext context, {String text = Strings.loading}) {
    if (_controller?.update(text) ?? false)
      return;
    else
      _controller = showOverlay(context, text);
  }

  void hide() {
    if (_controller != null) {
      _controller!.close();
      _controller = null;
    }
  }

  LoadingScreenController? showOverlay(BuildContext context, String text) {
    final textController = StreamController<String>();
    textController.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black54,
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              minWidth: size.width * 0.5,
              maxWidth: size.width * 0.8,
              maxHeight: size.height * 0.8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.06),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    loadingIndicator,
                    SizedBox(height: size.width * 0.04),
                    StreamBuilder<String>(
                      stream: textController.stream,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data ?? '',
                          style: TextStyle(color: Colors.black),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    final state = Overlay.of(context);
    state.insert(overlay);

    _controller = LoadingScreenController(
      close: () {
        overlay.remove();
        textController.close();
        return true;
      },
      update: (text) {
        textController.add(text);
        return true;
      },
    );

    return _controller;
  }
}
