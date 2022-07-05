import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orphicnew/common/helpers.dart';

class OrphicTextField extends StatelessWidget {
  Widget? trailingWidget;
  TextEditingController? textEditingController;
  TextInputType? keyboardType;
  int? maxLength;
  Function(String)? onChanged;
  String? hintText;
  String heading;
  IconData icon;
  List<TextInputFormatter>? inputFormatters;
  OrphicTextField(
      {Key? key,
      this.textEditingController,
      this.onChanged,
      this.keyboardType,
      required this.heading,
      required this.icon,
      this.hintText = "",
      this.trailingWidget,
      this.maxLength,
      this.inputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 15,
              color: const Color(0xff868686),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              heading,
              style: const TextStyle(
                color: Color(0xff868686),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        TextField(
          inputFormatters: inputFormatters,
          controller: textEditingController,
          onChanged: onChanged,
          maxLength: maxLength,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            counterText: "",
            suffixIcon: trailingWidget,
            hintText: hintText,
            focusColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}
