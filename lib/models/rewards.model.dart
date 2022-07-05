import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/controllers/auth.controller.dart';
import 'package:orphicnew/controllers/items.controller.dart';
import 'package:orphicnew/controllers/rewards.controller.dart';
import 'package:orphicnew/responses/category.res.dart';
import 'package:orphicnew/responses/item.res.dart';
import 'package:orphicnew/responses/rewards.res.dart';
import 'package:orphicnew/responses/user.res.dart';

class RewardsModel extends MomentumModel<RewardsController> {
  List<RewardsResData> listOfRewards;

  RewardsModel(RewardsController controller, {required this.listOfRewards})
      : super(controller);

  @override
  void update({
    List<RewardsResData>? rewardsResUpdate,
  }) {
    RewardsModel(
      controller,
      listOfRewards: rewardsResUpdate ?? listOfRewards,
    ).updateMomentum();
  }
}
