import 'package:flutter/material.dart';
import 'package:flutter_web/page/home_page.dart';
import 'package:flutter_web/page/next_page.dart';
import 'package:flutter_web/page/not_found_page.dart';
import 'package:flutter_web/page/splash_page.dart';
import 'package:routemaster/routemaster.dart';

/// @author jd

final routes = RouteMap(
    onUnknownRoute: (_) => MaterialPage(
          key: ValueKey('notFound'),
          child: NotFoundPage(),
        ),
    routes: {
      '/': (_) => MaterialPage(
            key: ValueKey('splash'),
            child: SplashPage(),
          ),
      '/home': (_) => MaterialPage(
            key: ValueKey('home'),
            child: MyHomePage(),
          ),
      '/home/detail/:id': (route) => MaterialPage(
            key: ValueKey('detail'),
            child: NextPage(
              id: route.pathParameters['id'],
            ),
          ),
    });
