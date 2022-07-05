import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/common/helpers.dart';
import 'package:orphicnew/models/item.model.dart';
import 'package:orphicnew/models/rewards.model.dart';
import 'package:orphicnew/services/api.service.dart';

class RewardsController extends MomentumController<RewardsModel> {
  @override
  RewardsModel init() {
    return RewardsModel(this, listOfRewards: const []);
  }

  void fetchRewards() async {
    final apiService = service<OrApiService>();
    EasyLoading.show();
    final result = await apiService.fetchUserRewards();
    EasyLoading.dismiss();
    result.fold((data) {
      model.update(rewardsResUpdate: data);
    }, (err) {
      dp(err);
      EasyLoading.showError(err);
    });
  }
}
