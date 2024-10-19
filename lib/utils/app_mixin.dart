import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin AppMixin<T extends StatefulWidget> {
  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  Future<void> wait(Duration duration) async {
    await Future.delayed(duration);
  }

  Widget animatedChildSwitcher({
    required Widget currentChild,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final tween = Tween(begin: 0.0, end: 1.0);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );
        final opacityAnimation = tween.animate(curvedAnimation);

        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
      child: currentChild,
    );
  }
}
