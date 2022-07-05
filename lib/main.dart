import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/common/app_loading.dart';
import 'package:orphicnew/common/helpers.dart';
import 'package:orphicnew/constants.dart';
import 'package:orphicnew/controllers/auth.controller.dart';
import 'package:orphicnew/controllers/items.controller.dart';
import 'package:orphicnew/controllers/rewards.controller.dart';
import 'package:orphicnew/models/auth.model.dart';
import 'package:orphicnew/services/api.service.dart';
import 'package:orphicnew/services/storage.service.dart';
import 'package:orphicnew/views/categories.view.dart';
import 'package:orphicnew/views/items.view.dart';
import 'package:orphicnew/views/login.view.dart';
import 'package:orphicnew/views/rewards.view.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Color(0xffe5e5e5), // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isFirstTime = true;
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Momentum(
      appLoader: Container(
        color: AppColors.BGCOLOR,
        child: Center(
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
      services: [OrApiService(), OrStorageService()],
      controllers: [
        AuthController(),
        ItemController(),
        RewardsController(),
      ],
      child: GetMaterialApp(
        title: 'Orphic',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Raleway",
          primarySwatch: Colors.amber,
        ),
        builder: EasyLoading.init(),
        home: SafeArea(
            child: MomentumBuilder(
                controllers: [AuthController],
                builder: (context, snapshot) {
                  bool? isAuth = snapshot<AuthModel>().isAuthenticated;
                  if (isAuth == null) {
                    return const AppLoading();
                  }

                  Widget screenToShow = const LoginView();
                  if (isAuth) {
                    screenToShow = CategoriesView(isFirstTime: isFirstTime);
                    isFirstTime = false;
                  }
                  return screenToShow;
                })),
      ),
    );
  }
}
