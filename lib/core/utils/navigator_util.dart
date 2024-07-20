import 'package:flutter/material.dart';

class Navify {
  static final Navify _instance = Navify._internal();

  factory Navify() {
    return _instance;
  }

  Navify._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get currentContext {
    return navigatorKey.currentState?.context;
  }

  Future<dynamic> navigateTo(Widget page, {dynamic arguments}) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  Future<dynamic> replaceWith(Widget page, {dynamic arguments}) {
    return navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  Future<dynamic> pushAndRemoveUntil(Widget page, {dynamic arguments}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(arguments: arguments),
      ),
      (route) => false,
    );
  }

  void popUntil(String routeName) {
    return navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  Future<dynamic> popAndPushNamed(String page, {dynamic arguments}) {
    return navigatorKey.currentState!.popAndPushNamed(page, arguments: arguments);
  }

  void popUntilRoute(RoutePredicate predicate) {
    return navigatorKey.currentState!.popUntil(predicate);
  }

  void popUntilFirst() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  bool isFirstRouteInStack() {
    return navigatorKey.currentState!.canPop();
  }
}
