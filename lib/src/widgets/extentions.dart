import 'package:flutter/material.dart';

extension OnPressed on Widget {
  Widget ripple( Function? onPressed, {
    BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(5))
  }) {
    return Stack(
      children: [
        this,
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: borderRadius)
              )
            ),
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              }
            },
            child: Container(),
          ),
        )
      ],
    );
  }
}