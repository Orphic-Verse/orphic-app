import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/common/helpers.dart';
import 'package:orphicnew/common/or_back_button.dart';
import 'package:orphicnew/constants.dart';
import 'package:orphicnew/controllers/auth.controller.dart';
import 'package:orphicnew/controllers/rewards.controller.dart';
import 'package:orphicnew/models/auth.model.dart';
import 'package:orphicnew/models/rewards.model.dart';
import 'package:orphicnew/responses/rewards.res.dart';
import 'package:orphicnew/responses/user.res.dart';
import 'package:orphicnew/views/reward_details.view.dart';

class RewardsView extends StatefulWidget {
  RewardsView({Key? key}) : super(key: key);

  @override
  _RewardsViewState createState() => _RewardsViewState();
}

class _RewardsViewState extends State<RewardsView> {
  final imgPaths = [
    'assets/images/rewards1.png',
    'assets/images/rewards2.png',
    'assets/images/rewards3.png',
  ];
  final rnd = Random();
  String name = "";
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      // Momentum.controller<RewardsController>(context).fetchRewards();
      final authController = Momentum.controller<AuthController>(context);
      authController.postStat(
          eventType: EVENT_TYPES.USER_ENTERED_REWARDS_SCREEN,
          idType: ID_TYPE.noIdDataNeeded);
      String? userName = authController.model.userData?.user?.name;

      setState(() {
        name = userName ?? "";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Momentum.controller<AuthController>(context).postStat(
            eventType: EVENT_TYPES.USER_EXITED_REWARDS_SCREEN,
            idType: ID_TYPE.noIdDataNeeded);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.BGCOLOR,
        body: Stack(
          children: [
            MomentumBuilder(
                controllers: [AuthController],
                builder: (context, snapshot) {
                  List<RewardItem> listOfRewards =
                      snapshot<AuthModel>().userData?.rewards?.rewards ?? [];
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(24),
                      itemCount: listOfRewards.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ySpace(118),
                              Text(
                                "Welcome, $name",
                                style: TextStyle(
                                  overflow: TextOverflow.clip,
                                  color: AppColors.DARKCOLOR,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ),
                              ySpace(24),
                            ],
                          );
                        }
                        bool isActive = false;
                        try {
                          bool comesAfter = DateTime.now().isAfter(
                              DateTime.parse(
                                  listOfRewards[index - 1].eligibleFrom ??
                                      "12/02/2100"));
                          isActive = comesAfter;
                        } catch (err) {
                          dp(err);
                        }
                        return RewardsContainer(
                            imagePath: index - 1 < 3
                                ? imgPaths[index - 1]
                                : imgPaths[rnd.nextInt(3)],
                            isActive: isActive,
                            reward: listOfRewards[index - 1]);
                      });
                }),
            Container(
              padding: const EdgeInsets.all(16),
              height: 118,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xfff5d4c1),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    backButton(onPressed: () {
                      Momentum.controller<AuthController>(context).postStat(
                          eventType: EVENT_TYPES.USER_EXITED_REWARDS_SCREEN,
                          idType: ID_TYPE.noIdDataNeeded);
                      Get.back();
                    }),
                    xSpace(16),
                    Text(
                      "Discounts",
                      style: TextStyle(
                        color: AppColors.DARKCOLOR,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    xSpace(8),
                    Image.asset(
                      'assets/images/coupon.png',
                      width: 40,
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RewardsContainer extends StatelessWidget {
  bool isActive = false;
  String imagePath;
  RewardItem reward;
  RewardsContainer(
      {Key? key,
      required this.isActive,
      required this.reward,
      required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = isActive ? Colors.white : const Color(0xff1a1a1a);
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
          // height: 148,
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(16),
            color: Color(isActive ? 0xffff8100 : 0xfff7f7f7),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${reward.message}",
                      style: TextStyle(
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: textColor),
                    ),
                    ySpace(15),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            isActive ? Colors.white : const Color(0xfff7f7f7)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(
                              width: 1,
                              color: isActive
                                  ? Colors.black
                                  : const Color(0xff9999a5),
                            ),
                          ),
                        ),
                      ),
                      // ElevatedButton.styleFrom(primary: Colors.white,),
                      onPressed: isActive
                          ? () {
                              Momentum.controller<AuthController>(context)
                                  .postStat(
                                      eventType: EVENT_TYPES.USER_OPENED_REWARD,
                                      idType: ID_TYPE.rewardId,
                                      data: reward.sId);
                              Get.to(() => RewardDetailsView(reward: reward));
                            }
                          : null,
                      child: Text(
                        reward.isRedeemed ?? true ? "REDEEMED" : 'REDEEM CODE',
                        style: TextStyle(
                          color:
                              isActive ? Colors.black : const Color(0xff9999a5),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    // isActive
                    // ?
                    "Valid from ${humanFormat(reward.eligibleFrom)}",
                    // : "Date is null",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  // ySpace(8),
                  Image.asset(
                    imagePath,
                    height: 80,
                    width: 80,
                  ),
                ],
              ),
              xSpace(30),
            ],
          ),
        ),
        Positioned(
          right: -30,
          bottom: (148 / 2) - 5,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.BGCOLOR,
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
