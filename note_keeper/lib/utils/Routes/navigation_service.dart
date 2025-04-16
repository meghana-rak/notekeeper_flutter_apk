import 'package:flutter/material.dart';

class NavigationService {
  const NavigationService();

  ///Customise Navigation Services
  Future<T?> push<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget page, {
    TO? result,
  }) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
      result: result,
    );
  }

  Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return Navigator.of(context).pushReplacementNamed(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
