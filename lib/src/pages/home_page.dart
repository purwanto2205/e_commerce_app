import 'package:e_commerce_app/src/model/data.dart';
import 'package:e_commerce_app/src/themes/light_color.dart';
import 'package:e_commerce_app/src/themes/theme.dart';
import 'package:e_commerce_app/src/widgets/product_card.dart';
import 'package:e_commerce_app/src/widgets/product_icon.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title = '' }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget _icon(IconData icon, Color color) {
    return InkWell(
      onTap: () {},
      borderRadius: const BorderRadius.all(Radius.circular(13)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).primaryColor,
          boxShadow: AppTheme.shadow,
        ),
        child: Icon(
          icon,
          color: color
        ),
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList
            .map((category) => ProductIcon(
          model: category,
          onSelected: (model) {
            setState(() {
              for (var element in AppData.categoryList) {
                element.isSelected = false;
              }
              model.isSelected = true;
            });
          },
        )).toList(),
      ),
    );
  }

  Widget _productWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: AppTheme.fullWidth(context) * .7,
      width: AppTheme.fullWidth(context),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4/3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
        ),
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        children: AppData.productList.map((product) => ProductCard(
          product: product,
          onSelected: (model) {
            setState(() {
              for (var element in AppData.productList) {
                element.isSelected = false;
              }
              model.isSelected = true;
            });
          },
        )).toList(),
      ),
    );
  }

  Widget _search() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const TextField(
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Product',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54,),
                  ),
                ),
              )),
          const SizedBox( width: 20.0,),
          _icon(Icons.filter_list, Colors.black54),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 210,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _search(),
            _categoryWidget(),
            _productWidget(),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
