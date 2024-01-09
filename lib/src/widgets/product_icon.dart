import 'package:e_commerce_app/src/model/category.dart';
import 'package:e_commerce_app/src/themes/light_color.dart';
import 'package:e_commerce_app/src/themes/theme.dart';
import 'package:e_commerce_app/src/widgets/title_text.dart';
import 'package:flutter/material.dart';

class ProductIcon extends StatelessWidget {

  final ValueChanged<Category> onSelected;
  final Category model;


  const ProductIcon({ Key? key, required this.onSelected, required this.model })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: InkWell(
        onTap: () {
          onSelected(
            model
          );
        },
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: AppTheme.hPadding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: model.isSelected
                ? LightColor.background
                : Colors.transparent,
            border: Border.all(
              color: model.isSelected ? LightColor.orange : LightColor.grey,
              width: model.isSelected ? 2 : 1,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: model.isSelected ? const Color(0xfffbf2ef) : Colors.white,
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(5, 5),
              )
            ]
          ),
          child: Row(
            children: <Widget>[
              model.image != null ? Image.asset(model.image!) : const SizedBox(),
              model.name != null ? TitleText(
                text: model.name!,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
