import 'package:e_commerce_app/src/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/src/pages/main_page.dart';
import 'package:e_commerce_app/src/pages/product_detail.dart';
import 'package:e_commerce_app/src/widgets/custom_route.dart';
import 'package:e_commerce_app/src/config/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: Theme.of(context).textTheme
      ),
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name!.contains('detail')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => const ProductDetailPage(),
              settings: settings
          );
        } else {
          return CustomRoute<bool>(
              builder: (BuildContext context) => const MainPage(title: 'MainPage',),
              settings: settings
          );
        }
      },
      initialRoute: 'MainPage',
    );
  }
}