import 'dart:convert';

class UserRes {
  int? statusCode;
  UserResData? data;

  UserRes({this.statusCode, this.data});

  UserRes.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? UserResData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class UserResData {
  User? user;
  Rewards? rewards;
  List<RewardsMessages>? rewardsMessages;

  UserResData({this.user, this.rewards, this.rewardsMessages});

  UserResData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rewards =
        json['rewards'] != null ? new Rewards.fromJson(json['rewards']) : null;
    if (json['rewardsMessages'] != null) {
      rewardsMessages = [];
      json['rewardsMessages'].forEach((v) {
        rewardsMessages?.add(new RewardsMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    if (this.rewards != null) {
      data['rewards'] = this.rewards?.toJson();
    }
    if (this.rewardsMessages != null) {
      data['rewardsMessages'] =
          this.rewardsMessages?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? sId;
  String? phoneNumber;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.phoneNumber,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phoneNumber'] = this.phoneNumber;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Rewards {
  bool? newlyAlloted;
  List<RewardItem>? rewards;
  int? currentTier;

  Rewards({this.newlyAlloted, this.rewards, this.currentTier});

  Rewards.fromJson(Map<String, dynamic> json) {
    newlyAlloted = json['newlyAlloted'];
    if (json['rewards'] != null) {
      rewards = [];
      json['rewards'].forEach((v) {
        rewards?.add(RewardItem.fromJson(v));
      });
    }
    currentTier = json['currentTier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newlyAlloted'] = this.newlyAlloted;
    if (this.rewards != null) {
      data['rewards'] = this.rewards?.map((v) => v.toJson()).toList();
    }
    data['currentTier'] = this.currentTier;
    return data;
  }
}

class RewardItem {
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
  int? iV;
  String? message;

  RewardItem(
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

  RewardItem.fromJson(Map<String, dynamic> json) {
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
    iV = json['__v'];
    message = json['message'];
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
    data['__v'] = this.iV;
    data['message'] = this.message;
    return data;
  }
}

class RewardsMessages {
  String? title;
  String? message;

  RewardsMessages({this.title, this.message});

  RewardsMessages.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}


// ProfileRes profileResFromJson(String str) =>
//     ProfileRes.fromJson(json.decode(str));

// String profileResToJson(ProfileRes data) => json.encode(data.toJson());

// class ProfileRes {
//   ProfileRes({
//     required this.statusCode,
//     required this.data,
//   });

//   int statusCode;
//   UserResData data;

//   factory ProfileRes.fromJson(Map<dynamic, dynamic>? json) => ProfileRes(
//         statusCode: json?["statusCode"],
//         data: UserResData.fromJson(json?["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "statusCode": statusCode,
//         "data": data.toJson(),
//       };
// }

// class UserResData {
//   UserResData({
//     required this.id,
//     required this.phoneNumber,
//     required this.name,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   String id;
//   String phoneNumber;
//   String name;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;

//   factory UserResData.fromJson(Map<String, dynamic> json) => UserResData(
//         id: json["_id"],
//         phoneNumber: json["phoneNumber"],
//         name: json["name"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "phoneNumber": phoneNumber,
//         "name": name,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }
