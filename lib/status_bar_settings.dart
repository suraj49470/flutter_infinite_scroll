import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBar extends StatelessWidget {
  final Widget child;
  const StatusBar({this.child});
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarDividerColor: Colors.transparent),
        child: child);
  }
}
