import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  navigate(Widget widget) {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  navigateReplave(Widget widget) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  Future<void> showDialog(
    //BuildContext? context,
    Widget widget,
  ) async {
    await showAdaptiveDialog(
      barrierDismissible: true,
      context: /*context ?? */ navigatorKey.currentContext!,
      builder: (context) => widget,
    );
  }

  void showSnackbar() {
    final context = navigatorKey.currentContext!;
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    final snackBarWidget = SnackBar(
        content: Text(
      'Hello World! - Movies App',
      style: TextStyle(
        color: Colors.white,
      ),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBarWidget);
  }
}
