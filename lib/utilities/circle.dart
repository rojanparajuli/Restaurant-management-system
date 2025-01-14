import 'package:flutter/material.dart';
import 'package:resturant/api/colors.dart';



  Widget buildBackgroundCircles(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: -100,
          right: -100,
          child: Container(
            height: 250,
            width: 250,
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            height: 250,
            width: 250,
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }