import 'package:flutter/material.dart';

class ExternalLoginButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color backgroundColor;
  final Color titleColor;
  final Function() onTap;

  ExternalLoginButton(
      {required this.title,
      required this.iconPath,
      required this.backgroundColor,
      required this.titleColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      width: double.infinity,
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              iconPath,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: onTap,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
