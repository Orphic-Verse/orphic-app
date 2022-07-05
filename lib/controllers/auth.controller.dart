import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/common/helpers.dart';
import 'package:orphicnew/constants.dart';
import 'package:orphicnew/models/auth.model.dart';
import 'package:orphicnew/services/api.service.dart';
import 'package:orphicnew/services/storage.service.dart';

enum EVENT_TYPES {
  USER_OPENED_VIEW_AR,
  USER_CLOSED_VIEW_AR,
  USER_OPENED_MODEL,
  USER_CLOSED_MODEL,
  USER_ENTERED_REWARDS_SCREEN,
  USER_EXITED_REWARDS_SCREEN,
  USER_CANCELLED_POPUP,
  USER_ACCEPTED_POPUP,
  USER_OPENED_REWARD,
  USER_CLOSED_REWARD,
  USER_OPENED_CATEGORY,
  USER_CLOSED_CATEGORY,
  USER_OPENED_ITEM,
  USER_CLOSED_ITEM
}

enum ID_TYPE {
  noIdDataNeeded,
  itemId,
  rewardId,
  categoryId,
}

class AuthController extends MomentumController<AuthModel> {
  @override
  bool get isLazy => false;

  @override
  AuthModel init() {
    return AuthModel(
      this,
      isAuthenticated: null,
      userName: "",
      phoneNumber: '',
      otp: '',
    );
  }

  @override
  Future<void> bootstrapAsync() async {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..textColor = AppColors.DARKCOLOR
      ..indicatorColor = AppColors.DARKCOLOR
      ..backgroundColor = AppColors.PRIMARYCOLOR
      ..indicatorType = EasyLoadingIndicatorType.fadingFour;
    final apiService = service<OrApiService>();
    final localStorageService = service<OrStorageService>();
    await localStorageService.init();
    apiService.init();
    fetchProfile();
  }

  void fetchProfile() async {
    final apiService = service<OrApiService>();
    // EasyLoading.show();
    final result = await apiService.fetchProfile();
    // EasyLoading.dismiss();
    result.fold((data) {
      model.update(userResDataUpdate: data, isAuth: true);
    }, (err) {
      model.update(isAuth: false);
      dp(err);
    });
  }

  Future<bool> generateOtp(String phoneNumber) async {
    final apiService = service<OrApiService>();
    EasyLoading.show();
    final result = await apiService.generateOTP(phoneNumber);
    EasyLoading.dismiss();
    bool isSuccess = false;
    result.fold((data) {
      isSuccess = true;
      EasyLoading.showSuccess("OTP Generated");
    }, (err) {
      EasyLoading.showError(err);
    });
    return isSuccess;
  }

  void verifyOtp(
      {required String phoneNumber,
      required String otp,
      required String name,
      String? clientId}) async {
    final apiService = service<OrApiService>();
    EasyLoading.show();
    final result = await apiService.verifyOTP(
        phoneNumber: phoneNumber,
        otp: otp,
        clientId: clientId ?? "777",
        name: name);
    EasyLoading.dismiss();

    result.fold((data) async {
      EasyLoading.showSuccess("OTP Verified");
      final localStorageService = service<OrStorageService>();
      final apiService = service<OrApiService>();
      await localStorageService.setToken(data.token);
      apiService.updateAuthToken(data.token);
      model.update(
        phoneNumberUpdate: phoneNumber,
        userNameUpdate: name,
      );
      fetchProfile();
    }, (err) => EasyLoading.showError(err));
  }

  Future<void> postStat(
      {required EVENT_TYPES eventType,
      required ID_TYPE idType,
      String? data}) async {
    final apiService = service<OrApiService>();
    String idTypeAsString = idType.toString().substring(
          idType.toString().indexOf('.') + 1,
          idType.toString().length,
        );
    String eventTypeAsString = eventType.toString().substring(
          eventType.toString().indexOf('.') + 1,
          eventType.toString().length,
        );
    final dataToPost = {
      "event": eventTypeAsString,
    };
    if (idType != ID_TYPE.noIdDataNeeded) {
      dataToPost[idTypeAsString] = data ?? "";
    }
    apiService.postStats(postData: dataToPost);
  }
}
