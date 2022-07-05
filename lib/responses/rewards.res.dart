class RewardsRes {
  int? statusCode;

  List<RewardsResData>? data;

  RewardsRes({this.statusCode, this.data});
  RewardsRes.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <RewardsResData>[];
      json['data'].forEach((v) {
        data?.add(RewardsResData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RewardsResData {
  String? sId;
  int? discountPercentage;
  String? eligibleFrom;
  int? tier;
  bool? isRedeemed;
  bool? isExpired;
  String? expires;
  String? clientId;
  String? user;
  String? code;
  String? createdAt;
  String? updatedAt;
  String? message;
  int? iV;

  RewardsResData(
      {this.sId,
      this.discountPercentage,
      this.eligibleFrom,
      this.tier,
      this.isRedeemed,
      this.isExpired,
      this.expires,
      this.clientId,
      this.user,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.message});

  RewardsResData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    discountPercentage = json['discountPercentage'];
    eligibleFrom = json['eligibleFrom'];
    tier = json['tier'];
    isRedeemed = json['isRedeemed'];
    isExpired = json['isExpired'];
    expires = json['expires'];
    clientId = json['clientId'];
    user = json['user'];
    code = json['code'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    message = json['message'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['discountPercentage'] = this.discountPercentage;
    data['eligibleFrom'] = this.eligibleFrom;
    data['tier'] = this.tier;
    data['isRedeemed'] = this.isRedeemed;
    data['isExpired'] = this.isExpired;
    data['expires'] = this.expires;
    data['clientId'] = this.clientId;
    data['user'] = this.user;
    data['code'] = this.code;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['message'] = this.message;
    data['__v'] = this.iV;
    return data;
  }
}
