// To parse this JSON data, do
//
//     final generateOtpRes = generateOtpResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GenerateOtpRes generateOtpResFromJson(String str) =>
    GenerateOtpRes.fromJson(json.decode(str));

String generateOtpResToJson(GenerateOtpRes data) => json.encode(data.toJson());

class GenerateOtpRes {
  GenerateOtpRes({
    required this.statusCode,
    required this.data,
  });

  int statusCode;
  String data;

  factory GenerateOtpRes.fromJson(Map<dynamic, dynamic>? json) =>
      GenerateOtpRes(
        statusCode: json?["statusCode"],
        data: json?["data"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data,
      };
}
