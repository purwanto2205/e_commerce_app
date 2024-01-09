import 'package:e_commerce_app/src/model/data.dart';
import 'package:e_commerce_app/src/model/product.dart';
import 'package:e_commerce_app/src/themes/light_color.dart';
import 'package:e_commerce_app/src/themes/theme.dart';
import 'package:e_commerce_app/src/widgets/title_text.dart';
import 'package:flutter/material.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _cartItems(),
            const Divider(
              thickness: 1,
              height: 70,
            ),
            _price(),
           const SizedBox(height: 30,),
            _submitButton(context)
          ],
        ),
      ),
    );
  }

  Widget _cartItems() {
    return Column(
      children: AppData.cartList.map((item) => _items(item)).toList(),
    );
  }

  Widget _items(Product item) {
    return SizedBox(
        height: 80,
        child: Row(
          children: [
              AspectRatio(
                aspectRatio: 1.2,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: LightColor.lightGrey,
                            borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                    Positioned(
                        left: -20,
                        bottom: -20,
                        child: Image.asset(item.image)
                    )
                  ],
                ),
              ),
            Expanded(
              child: ListTile(
                title: TitleText(
                  text: item.name,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                subtitle: Row(
                  children: [
                    const TitleText(
                      text: '\$',
                      color: LightColor.red,
                      fontSize: 12,
                    ),
                    TitleText(
                      text: '${item.price}',
                      fontSize: 14,
                    )
                  ],
                ),
                trailing: Container(
                  height: 35,
                  width: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: LightColor.lightGrey.withAlpha(150),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TitleText(
                    text: 'x${item.id}',
                    fontSize: 15,
                  ),
                ),
              ),
            )
            ],
          ),
      );
  }

  Row _price() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(
                text: '${AppData.cartList.length} items',
                color: LightColor.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              TitleText(text: '\$${getPrice()}', fontSize: 18,),
            ],
          );
  }

  Widget _submitButton(context) => TextButton(
      onPressed: () {},
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))
          ),
          backgroundColor: MaterialStateProperty.all<Color>(LightColor.orange)
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4),
        width: AppTheme.fullWidth(context) * .75,
        child: const TitleText(
          text: 'Next',
          color: LightColor.background,
          fontWeight: FontWeight.w500,
        ),
      )
  );

  double getPrice() {
    double price = 0;
    for (var element in AppData.cartList) {
      price += element.price;
    }
    return price;
  }
}
