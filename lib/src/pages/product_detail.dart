import 'package:e_commerce_app/src/model/data.dart';
import 'package:e_commerce_app/src/themes/light_color.dart';
import 'package:e_commerce_app/src/themes/theme.dart';
import 'package:e_commerce_app/src/widgets/extentions.dart';
import 'package:e_commerce_app/src/widgets/title_text.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300)
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.forward();
  }


  bool isLiked = true;

  Color selectedColor = LightColor.yellowColor;

  void _updateSelectedColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  List<Color> colorList = [
    LightColor.yellowColor,
    LightColor.lightBlue,
    LightColor.black,
    LightColor.red,
    LightColor.skyBlue,
  ];

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutline: true,
          ),
          _icon(
              size: 15,
              padding: 12,
              icon: isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? LightColor.red : LightColor.lightGrey,
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              }
          )
        ],
      ),
    );
  }

  Widget _icon({
    required IconData icon,
    Color color = LightColor.iconColor,
    double size = 20,
    double padding = 10,
    bool isOutline = false,
    required Function onPressed,
  }) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            border: Border.all(
              color: LightColor.iconColor,
              style: isOutline ? BorderStyle.solid :  BorderStyle.none,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            color: isOutline ? Colors.transparent : Theme.of(context).primaryColor,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0xfff8f8f8),
                blurRadius: 5,
                spreadRadius: 10,
                offset: Offset(5,5),
              )
            ]
        ),
        child: Icon(icon, color: color, size: size,),
      ),
    );
  }

  Widget _productImage() {
    return AnimatedBuilder(
        builder: (BuildContext context, Widget? child) {
          return AnimatedOpacity(
            opacity: animation.value,
            duration: const Duration(milliseconds: 500),
            child: child,
          );
        },
        animation: animation,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const TitleText(
              text: 'AIP',
              fontSize: 160,
              color: LightColor.lightGrey,
            ),
            Image.asset('assets/show_1.png')
          ],
        ),
      );
  }

  Widget _categoryWidget() {
    return Container(
      width: AppTheme.fullWidth(context),
      margin: const EdgeInsets.symmetric(vertical: 0),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AppData.showThumbnailList.map((e) => _thumbnail(e)).toList(),
      ),
    );
  }

  Widget _thumbnail(String thumbnail) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => AnimatedOpacity(
        opacity: animation.value,
        duration: const Duration(milliseconds: 500),
        child: child,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: InkWell(
          onTap: () {

          },
          child: Container(
            height: 40,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: LightColor.grey
              ),
              borderRadius: const BorderRadius.all(Radius.circular(13)),
            ),
            child: Image.asset(thumbnail),
          ),
        ),
      ),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (scroll, controller) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5,),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                      height: 5,
                    decoration: const BoxDecoration(
                      color: LightColor.iconColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleText(text: 'NIKE AIR MAX', fontSize: 25,),
                    Column(
                      children: [
                        Row(
                          children: [
                            TitleText(text: '\$', fontSize: 18, color: LightColor.red,),
                            TitleText(text: '240', fontSize: 25,),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.star,color: LightColor.yellowColor, size: 17,),
                            Icon(Icons.star,color: LightColor.yellowColor, size: 17,),
                            Icon(Icons.star,color: LightColor.yellowColor, size: 17,),
                            Icon(Icons.star,color: LightColor.yellowColor, size: 17,),
                            Icon(Icons.star, size: 17,),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                _availableSize(),
                const SizedBox(height: 20,),
                _availableColor(),
                const SizedBox(height: 20,),
                _description(),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _availableSize() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(text: 'Available Sizes', fontSize: 14,),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _sizeWidget('US 6'),
            _sizeWidget('US 7', isSelected: true),
            _sizeWidget('US 8'),
            _sizeWidget('US 9'),
          ],
        )
      ],
    );
  }

  Widget _sizeWidget(String text, { bool isSelected = false }) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          border: Border.all(
            color: LightColor.iconColor,
            width: 1,
            style: isSelected ? BorderStyle.none : BorderStyle.solid
          ),
          color: isSelected ? LightColor.orange : Colors.transparent,
        ),
        child: Center(
          child: TitleText(
            text: text,
            fontSize: 12,
            color: isSelected
                ? LightColor.background
                : LightColor.titleTextColor,
          ),
        ),
      ),
    );
  }

  Widget _availableColor() {
    return Column(
      children: [
        const TitleText(text: 'Colors', fontSize: 14,),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: colorList.map((c) =>
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: _colorWidget(c, isSelected: c == selectedColor),
              ))
              .toList(),
        )
      ],
    );
  }

  Widget _colorWidget(Color color, {bool isSelected = false}) {
    return CircleAvatar(
        radius: 16,
        backgroundColor: color.withAlpha(150),
        child: isSelected
            ? Icon(Icons.check_circle, color: color, size: 25,)
            : CircleAvatar(radius: 10, backgroundColor: color,)
    ).ripple(
        () => _updateSelectedColor(color),
      borderRadius: const BorderRadius.all(Radius.circular(16))
    );
  }

  Widget _description() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(text: 'Description', fontSize: 14,),
        const SizedBox(height: 20,),
        Text(AppData.description),
        const SizedBox(height: 20,),
      ],
    );
  }

  FloatingActionButton _floatingButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: LightColor.orange,
      child: Icon(Icons.shopping_basket,
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingButton(),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xfffbfbfb),
                Color(0xfff7f7f7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(),
                  _categoryWidget(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }
}
