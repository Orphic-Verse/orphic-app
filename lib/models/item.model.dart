import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/controllers/auth.controller.dart';
import 'package:orphicnew/controllers/items.controller.dart';
import 'package:orphicnew/responses/category.res.dart';
import 'package:orphicnew/responses/item.res.dart';
import 'package:orphicnew/responses/user.res.dart';

class ItemModel extends MomentumModel<ItemController> {
  List<CategoryData> listOfCategories;
  List<ItemResData> currentFetchedItems;
  List<String> subCats;

  ItemModel(
    ItemController controller, {
    required this.listOfCategories,
    required this.currentFetchedItems,
    required this.subCats,
  }) : super(controller);

  @override
  void update(
      {List<CategoryData>? listOfCategoriesUpdate,
      List<ItemResData>? currentFetchedItemsUpdate,List<String>?  subCatsUpdate}) {
    ItemModel(
      controller,
      listOfCategories: listOfCategoriesUpdate ?? listOfCategories,
      currentFetchedItems: currentFetchedItemsUpdate ?? currentFetchedItems,
      subCats: subCatsUpdate ?? subCats,
    ).updateMomentum();
  }
}
