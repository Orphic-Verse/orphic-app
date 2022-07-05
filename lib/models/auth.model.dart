import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/controllers/auth.controller.dart';
import 'package:orphicnew/responses/user.res.dart';

/// Model for user auth
class AuthModel extends MomentumModel<AuthController> {
  /// Decides if the Application is in an authenticated state or not
  bool? isAuthenticated;

  String userName;

  String phoneNumber, otp;

  UserResData? userData;

  ///
  AuthModel(AuthController controller,
      {required this.isAuthenticated,
      required this.userName,
      required this.phoneNumber,
      required this.otp,
      this.userData
      // @required this.isDeeplinkInfoPosted,
      })
      : super(controller);

  @override
  void update({
    bool? isAuth,
    String? userNameUpdate,
    String? phoneNumberUpdate,
    String? otpUpdate,
    UserResData? userResDataUpdate,
  }) {
    AuthModel(controller,
            isAuthenticated: isAuth ?? isAuthenticated,
            userName: userNameUpdate ?? userName,
            otp: otpUpdate ?? otp,
            phoneNumber: phoneNumberUpdate ?? phoneNumber,
            userData: userResDataUpdate ?? userData)
        .updateMomentum();
  }
}
