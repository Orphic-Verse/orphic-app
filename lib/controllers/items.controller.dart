import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/common/helpers.dart';
import 'package:orphicnew/models/item.model.dart';
import 'package:orphicnew/services/api.service.dart';

class ItemController extends MomentumController<ItemModel> {
  @override
  ItemModel init() {
    return ItemModel(this,
        listOfCategories: const [],
        currentFetchedItems: const [],
        subCats: const []);
  }

  @override
  Future<void> bootstrapAsync() async {}

  void fetchCategories() async {
    final apiService = service<OrApiService>();
    EasyLoading.show();
    final result = await apiService.fetchCategories();
    EasyLoading.dismiss();
    result.fold((data) {
      model.update(listOfCategoriesUpdate: data);
    }, (err) {
      dp(err);
      EasyLoading.showError(err);
    });
  }

  void fetchItemsWithCategoryId(String categoryId) async {
    final apiService = service<OrApiService>();
    EasyLoading.show();
    final result = await apiService.fetchItemsWithCategoryId(categoryId);
    EasyLoading.dismiss();
    result.fold((data) {
      Set<String> subCats = {};

      for (final item in data ?? []) {
        subCats.add(item.subCategory ?? "");
      }
      model.update(
          currentFetchedItemsUpdate: data, subCatsUpdate: subCats.toList());
    }, (err) {
      dp(err);
      EasyLoading.showError(err);
    });
  }

  void clearFetchedItems() {
    model.update(currentFetchedItemsUpdate: [], subCatsUpdate: []);
  }
}
