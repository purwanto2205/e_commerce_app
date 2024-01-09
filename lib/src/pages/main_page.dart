import 'package:e_commerce_app/src/pages/home_page.dart';
import 'package:e_commerce_app/src/pages/shopping_cart_page.dart';
import 'package:e_commerce_app/src/themes/light_color.dart';
import 'package:e_commerce_app/src/themes/theme.dart';
import 'package:e_commerce_app/src/widgets/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:e_commerce_app/src/widgets/title_text.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  bool isHomePageSelected = true;

  void onBottomIconPressed(int index) {
    setState(() {
      isHomePageSelected = index == 0 || index == 1;
    });
  }


  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(quarterTurns: 4, child: _icon(Icons.sort, color: Colors.black54),),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    blurRadius: 10,
                    color: Color(0xfff8f8f8),
                    spreadRadius: 10,
                  )
                ]
              ),
              child: Image.asset('assets/user.png'),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: isHomePageSelected ? 'Our' : 'Shopping',
                fontSize: 27,
                fontWeight: FontWeight.w400,
              ),
              TitleText(
                text: isHomePageSelected ? 'Products' : 'Cart',
                fontSize: 27,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
          const Spacer(),
          !isHomePageSelected
              ? Container(padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.delete_outline,
              color: LightColor.orange,
            ),
          )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget _icon(IconData icon, { Color color = LightColor.iconColor }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        color: Theme.of(context).primaryColor,
        boxShadow: AppTheme.shadow,
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _appBar(),
                    _title(),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInToLinear,
                        switchOutCurve: Curves.easeOutBack,
                        child: isHomePageSelected
                            ? const MyHomePage()
                            : const Align(
                          alignment: Alignment.topCenter,
                          child: ShoppingCartPage(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                onIconPressedCallback: onBottomIconPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
