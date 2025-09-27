import 'package:flutter/material.dart';

extension NamedNavigationExtension on BuildContext {
  /// Push a named route
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed<T>(this, routeName, arguments: arguments);
  }

  /// Replace current screen with named route
  Future<T?> pushReplacementNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.pushReplacementNamed<T, T>(
      this,
      routeName,
      arguments: arguments,
    );
  }

  /// Push a named route and remove all previous routes
  Future<T?> pushNamedAndRemoveAll<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Pop current screen
  void pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }

  /// Pop until a certain route
  void popUntil(RoutePredicate predicate) {
    Navigator.popUntil(this, predicate);
  }
}
