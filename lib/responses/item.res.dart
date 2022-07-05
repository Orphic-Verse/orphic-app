class ItemRes {
  int? statusCode;
  List<ItemResData>? data;

  ItemRes({this.statusCode, this.data});

  ItemRes.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <ItemResData>[];
      json['data'].forEach((v) {
        data!.add(ItemResData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemResData {
  String? sId;
  String? modelUrl;
  String? imageUrl;
  bool? isNonVeg;
  String? rate;
  String? subCategory;
  String? description;
  String? name;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? iV;
  MainCategory? mainCategory;

  ItemResData(
      {required this.sId,
      required this.modelUrl,
      required this.imageUrl,
      required this.isNonVeg,
      required this.rate,
      required this.subCategory,
      required this.description,
      required this.name,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.iV,
      required this.mainCategory});

  ItemResData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    modelUrl = json['modelUrl'];
    imageUrl = json['imageUrl'];
    isNonVeg = json['isNonVeg'];
    rate = json['rate'];
    subCategory = json['subCategory'];
    description = json['description'];
    name = json['name'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    mainCategory = json['mainCategory'] != null
        ? MainCategory.fromJson(json['mainCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['modelUrl'] = this.modelUrl;
    data['imageUrl'] = this.imageUrl;
    data['isNonVeg'] = this.isNonVeg;
    data['rate'] = this.rate;
    data['subCategory'] = this.subCategory;
    data['description'] = this.description;
    data['name'] = this.name;
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.mainCategory != null) {
      data['mainCategory'] = this.mainCategory!.toJson();
    }
    return data;
  }
}

class MainCategory {
  String? sId;
  bool? isSpecial;
  String? imageUrl;
  String? textColor;
  String? borderColor;
  String? backgroundColor;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MainCategory(
      {required this.sId,
      required this.isSpecial,
      required this.imageUrl,
      required this.textColor,
      required this.borderColor,
      required this.backgroundColor,
      required this.name,
      required this.type,
      required this.createdAt,
      required this.updatedAt,
      required this.iV});

  MainCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isSpecial = json['isSpecial'];
    imageUrl = json['imageUrl'];
    textColor = json['textColor'];
    borderColor = json['borderColor'];
    backgroundColor = json['backgroundColor'];
    name = json['name'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isSpecial'] = this.isSpecial;
    data['imageUrl'] = this.imageUrl;
    data['textColor'] = this.textColor;
    data['borderColor'] = this.borderColor;
    data['backgroundColor'] = this.backgroundColor;
    data['name'] = this.name;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
