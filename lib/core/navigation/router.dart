import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/home/home_view.dart';
import '../../features/login/login_view.dart';
import 'route.dart';

class AppRouter {
  AppRouter._();
  static final _instance = AppRouter._();
  factory AppRouter() => _instance;

  final _moduleRouterRegistration = <SubRouter>[
    // moduleARouter,
  ];

  Route onGenerateRoute(RouteSettings settings) {
    final routeComponents = settings.name!.split(' ');

    final module = _moduleRouterRegistration.firstWhere(
      (subRouter) => subRouter.moduleName == routeComponents[0],
      orElse: () => throw Exception(
        'Module with name ${routeComponents[0]} not registered in Router',
      ),
    );
    final routeName = routeComponents[1];
    final splitRouteSettings = RouteSettings(
      name: routeName,
      arguments: settings.arguments,
    );
    return getPageRoute(
      view: module.router(splitRouteSettings),
      settings: splitRouteSettings,
    );
  }

  PageRoute getPageRoute({
    required Widget view,
    required RouteSettings settings,
  }) {
    return Platform.isIOS
        ? CupertinoPageRoute(
            builder: (_) => view,
            settings: settings,
          )
        : MaterialPageRoute(
            builder: (_) => view,
            settings: settings,
          );
  }

  Map<String, WidgetBuilder> get routes => {
        startupRoute: (_) => const LoginView(),
        homeRoute: (_) => const HomeView(),
      };
}

abstract class SubRouter {
  String get moduleName;
  Widget router(RouteSettings settings);
}
