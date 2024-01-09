import 'package:e_commerce_app/src/model/product.dart';
import 'package:e_commerce_app/src/themes/light_color.dart';
import 'package:e_commerce_app/src/widgets/extentions.dart';
import 'package:e_commerce_app/src/widgets/title_text.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final ValueChanged<Product> onSelected;


  const ProductCard({Key? key, required this.product, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 15,
              spreadRadius: 10,
            )
          ]
        ),
        margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(product.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: product.isLiked ? LightColor.red : LightColor.iconColor,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: product.isSelected ? 15 :0 ,),
                  Expanded(child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                          backgroundColor: LightColor.orange.withAlpha(40),
                      ),
                      Image.asset(product.image)
                    ],
                  )),
                  TitleText(text: product.name, fontSize: product.isSelected ? 16 : 14,),
                  TitleText(text: product.category,
                    fontSize: product.isSelected ? 14 : 12,
                    color: LightColor.orange,
                  ),
                  TitleText(text: product.price.toString(), fontSize: product.isSelected ? 18 : 16,),
                ],
              )
            ],
          ),
        ),
      ).ripple(() {
          Navigator.pushNamed(context, '/detail');
          onSelected(product);
        },
        borderRadius: const BorderRadius.all(Radius.circular(20))
    );
  }
}
