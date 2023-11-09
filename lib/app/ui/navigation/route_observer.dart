import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class MyRouteObserver extends RoutemasterObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('Popped a route ${route.settings.name}');
  }

  // Routemaster-specific observer method
  @override
  void didChangeRoute(RouteData routeData, Page page) {
    debugPrint('New route: ${routeData.path}');
  }
}
