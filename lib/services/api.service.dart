import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/common/helpers.dart';
import 'package:orphicnew/responses/category.res.dart';
import 'package:orphicnew/responses/genereate_otp.res.dart';
import 'package:orphicnew/responses/item.res.dart';
import 'package:orphicnew/responses/otp_verif.res.dart';
import 'package:orphicnew/responses/rewards.res.dart';
import 'package:orphicnew/responses/user.res.dart';
import 'package:orphicnew/services/storage.service.dart';

class OrApiService extends MomentumService {
  /// HTTP Client to make API Calls
  final Dio _dio = Dio();

  /// API Base URL
  static const baseUrl = 'https://api.app.orphic.co.in';

  void init() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = {
      'accessToken': '${service<OrStorageService>().authToken}'
      // 'x-auth-token': service<OrStorageService>().authToken,
    };

    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      options.headers["clientId"] = "777";
      // dp(_dio.options.headers);
      debugPrint('${options.method} REQUESTING ${options.uri}');
      if (options.method != 'GET') {
        debugPrint("- with -");
        debugPrint("${options.data}");
      }
      handler.next(options);
    }, onResponse:
        (Response response, ResponseInterceptorHandler handler) async {
      debugPrint('${response.statusCode} RESPONSE \n${response.data}');
      handler.next(response);
    }, onError: (DioError e, ErrorInterceptorHandler handler) async {
      debugPrint("API Error");
      debugPrint('${e.response?.data}');
      handler.next(e);
    }));
  }

  updateAuthToken(String token) {
    _dio.options.headers = {
      'accessToken': token,
    };
  }

  Future<Either<UserResData?, String>> fetchProfile() async {
    try {
      final response = await _dio.get('/user/profile');
      return Left(UserRes.fromJson(response.data).data);
    } on DioError catch (e, s) {
      dp("Error fetching profile");
      dp(e);
      dp(s);
      return Right(e.message);
    } catch (e, s) {
      dp(e);
      dp(s);
      return const Right("Unknown Error while fetching profile");
    }
  }

  Future<Either<GenerateOtpRes, String>> generateOTP(String phoneNumber) async {
    try {
      final response = await _dio.post<Map>('/auth/otp/generate', data: {
        "phoneNumber": phoneNumber,
      });
      return Left(GenerateOtpRes.fromJson(response.data));
    } on DioError catch (e, stackTrace) {
      dp("Error while sending OTP");
      dp("$stackTrace");
    } catch (e, stackTrace) {
      dp("Unknown Error while sending OTP");

      dp("$stackTrace");
    }
    return const Right("Failed to generate OTP");
  }

  Future<Either<OtpVerifData, String>> verifyOTP(
      {required String phoneNumber,
      required String otp,
      required String name,
      required String clientId}) async {
    try {
      final response = await _dio.post<Map>('/auth/otp/verify', data: {
        "phoneNumber": phoneNumber,
        "otp": otp,
        'name': name,
        "clientId": clientId,
      });
      final data = OtpVerifRes.fromJson(response.data).data;
      return Left(data);
    } on DioError catch (e, stackTrace) {
      dp(e);
      dp(stackTrace);
      dp(e.response);
      try {
        if (e.response != null) {
          String error = e.response!.data['message'];
          return Right(error);
        }
      } catch (err) {
        dp(err);
      }

      return Right(e.message);
    } catch (e, s) {
      dp(e);
      dp(s);
      return const Right('Something went wrong, Please try again');
    }
  }

  Future<Either<List<CategoryData>?, String>> fetchCategories() async {
    try {
      final response = await _dio.get('/items/categories');
      final data = CategoryRes.fromJson(response.data);
      return Left(data.listOfCategories);
    } on DioError catch (e, stackTrace) {
      dp(e);
      dp(stackTrace);
      try {
        if (e.response != null) {
          String error = e.response!.data['message'];
          return Right(error);
        }
      } catch (err) {
        dp(err);
      }

      return Right(e.message);
    } catch (e, s) {
      dp(e);
      dp(s);
      return const Right('Something went wrong, Please try again');
    }
  }

  Future<Either<List<ItemResData>?, String>> fetchItemsWithCategoryId(
      String categoryId) async {
    try {
      final response = await _dio.get('/items/category/$categoryId');
      final data = ItemRes.fromJson(response.data);
      return Left(data.data);
    } on DioError catch (e, stackTrace) {
      dp(e);
      dp(stackTrace);
      return Right(e.message);
    } catch (e, s) {
      dp(e);
      dp(s);
      return const Right('Something went wrong, Please try again');
    }
  }

  Future<Either<List<RewardsResData>?, String>> fetchUserRewards() async {
    try {
      final response = await _dio.get('/rewards/user');
      final data = RewardsRes.fromJson(response.data);
      return Left(data.data);
    } on DioError catch (e, stackTrace) {
      dp(e);
      dp(stackTrace);
      return Right(e.message);
    } catch (e, s) {
      dp(e);
      dp(s);
      return const Right('Something went wrong, Please try again');
    }
  }

  Future<void> postStats({required Map<String, dynamic> postData}) async {
    try {
      await _dio.post('/stats', data: postData);
    } on DioError catch (e, s) {
      dp("===============> Error while posting stats");
      dp(e);
      dp(s);
    } catch (e, s) {
      dp("================< Erro while posting stats");
      dp(e);
      dp(s);
    }
  }
}
