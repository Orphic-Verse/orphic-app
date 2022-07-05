class CategoryRes {
  int? statusCode;
  List<CategoryData>? listOfCategories;

  CategoryRes({required this.statusCode, required this.listOfCategories});

  CategoryRes.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      listOfCategories = <CategoryData>[];
      json['data'].forEach((v) {
        listOfCategories?.add(CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['statusCode'] = statusCode;
    if (this.listOfCategories != null) {
      data['data'] = this.listOfCategories?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
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

  CategoryData(
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

  CategoryData.fromJson(Map<String, dynamic> json) {
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
