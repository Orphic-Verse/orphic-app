import 'package:flutter/material.dart';
import 'package:orphicnew/common/helpers.dart';

import '../constants.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGCOLOR,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),
            Image.asset(
              'assets/images/logo_text.png',
            ),
            const Spacer(),
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
            ySpace(60),
          ],
        ),
      ),
    );
  }
}
