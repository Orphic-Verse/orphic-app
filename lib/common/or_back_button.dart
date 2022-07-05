import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget backButton({required void Function()? onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      child: const Center(
        child: Icon(
          Icons.chevron_left_rounded,
        ),
      ),
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
