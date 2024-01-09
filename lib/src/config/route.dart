import 'package:flutter/material.dart';
import 'package:e_commerce_app/src/pages/main_page.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder> {
      '/': (context) => const MainPage(title: 'Main Page',),
    };
  }
}