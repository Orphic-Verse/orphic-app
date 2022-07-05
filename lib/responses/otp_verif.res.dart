// To parse this JSON data, do
//
//     final otpVerifRes = otpVerifResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OtpVerifRes otpVerifResFromJson(String str) =>
    OtpVerifRes.fromJson(json.decode(str));

String otpVerifResToJson(OtpVerifRes data) => json.encode(data.toJson());

class OtpVerifRes {
  OtpVerifRes({
    required this.statusCode,
    required this.data,
  });

  int statusCode;
  OtpVerifData data;

  factory OtpVerifRes.fromJson(Map<dynamic, dynamic>? json) => OtpVerifRes(
        statusCode: json?["statusCode"],
        data: OtpVerifData.fromJson(json?["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data.toJson(),
      };
}

class OtpVerifData {
  OtpVerifData({
    required this.token,
    required this.userId,
  });

  String token;
  String userId;

  factory OtpVerifData.fromJson(Map<dynamic, dynamic> json) => OtpVerifData(
        token: json["token"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "userId": userId,
      };
}
