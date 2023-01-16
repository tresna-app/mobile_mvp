import 'package:flutter/material.dart';

class OnboardingTile extends StatelessWidget {
  final logoPath, imagePath, title, mainText;

  OnboardingTile({this.logoPath, this.imagePath, this.title, this.mainText});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 34),
          Image.asset(
            logoPath,
            scale: 1.25,
          ),
          const SizedBox(height: 34),
          Expanded(
            child: Image.asset(
              imagePath,
            ),
          ),
          const SizedBox(height: 65),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 100,
            ),
            child: Text(
              mainText,
              style: const TextStyle(
                fontSize: 22.5,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
