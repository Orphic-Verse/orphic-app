import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/common/helpers.dart';
import 'package:orphicnew/common/or_text_field.dart';
import 'package:orphicnew/controllers/auth.controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String name = "";
  String phoneNumber = "";
  String otp = "";
  bool isOtpGenerated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe5e5e5),
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              SizedBox(
                height: 209,
                child: Stack(
                  children: [
                    Positioned(
                      left: 32,
                      bottom: 40,
                      child: Row(
                        children: [
                          Image.asset('assets/images/logo.png'),
                          const SizedBox(width: 11),
                          Image.asset('assets/images/logo_text.png'),
                        ],
                      ),
                    ),
                    Positioned(
                      child: Image.asset(
                        'assets/images/home_decor.png',
                        width: 200,
                        height: 200,
                      ),
                      right: -50,
                      bottom: -65,
                    ),
                    // Positioned(
                    //   child: Image.asset('assets/images/home_decor_2.png'),
                    //   right: -1,
                    //   bottom: -100,
                    // ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    // physics: const BouncingScrollPhysics(),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      ySpace(20),
                      OrphicTextField(
                        onChanged: (text) {
                          name = text.trim();
                        },
                        heading: "Name",
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.name,
                      ),
                      ySpace(25),
                      OrphicTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (text) {
                          phoneNumber = text.trim();
                        },
                        maxLength: 10,
                        heading: "Phone No.",
                        icon: Icons.phone,
                        // hintText: "Enter your phone number",
                        keyboardType: TextInputType.phone,
                        trailingWidget: TextButton(
                          child: const Text(
                            "Send OTP",
                            style: TextStyle(
                              color: Color(0xff5956e9),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () async {
                            if (phoneNumber.length != 10) {
                              Helper.showError("Enter a valid phone number");
                              return;
                            }
                            final isOtpGener =
                                await Momentum.controller<AuthController>(
                                        context)
                                    .generateOtp(phoneNumber);
                            if (isOtpGener) {
                              setState(() {
                                isOtpGenerated = isOtpGener;
                              });
                            }
                          },
                        ),
                      ),
                      ySpace(25),
                      isOtpGenerated
                          ? OrphicTextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (val) => otp = val.trim(),
                              heading: "OTP",
                              icon: Icons.pin,
                              keyboardType: TextInputType.number,
                            )
                          : nothingWidget,
                      ySpace(42),
                      Center(
                        child: SizedBox(
                          width: 314,
                          height: 70,
                          child: ElevatedButton(
                            child: const Text(
                              "Get Started",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(
                                  0xff1a1a1a,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              primary: const Color(0xffffac56),
                            ),
                            onPressed: isOtpGenerated
                                ? () async {
                                    if (name.isEmpty ||
                                        phoneNumber.length != 10) {
                                      Helper.showError(
                                          "Please input all details");
                                      return;
                                    }
                                    if (otp.isEmpty) {
                                      Helper.showError("Enter a valid OTP");
                                      return;
                                    }
                                    Momentum.controller<AuthController>(context)
                                        .verifyOtp(
                                            phoneNumber: phoneNumber,
                                            otp: otp,
                                            name: name);
                                  }
                                : null,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
