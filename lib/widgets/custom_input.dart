import 'package:clochard/view_Controller/auth_controller/login_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomInput extends StatelessWidget {
  final String? hintText;
  final String initialValue;
  final String? label;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  //final bool? isEmailField;
  final bool? isPasswordField;
  final TextInputType? keyboardType;
  final bool isNumber;
  final Color bgColor;
  const CustomInput(
      {Key? key,
      this.hintText = '',
      this.onChanged,
      this.textInputAction,
      this.isPasswordField,
      this.onSaved,
      this.validator,
      this.label = null,
      this.keyboardType,
      this.isNumber = false,
      this.bgColor = Colors.white,
      this.initialValue=''
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init:Get.put(LoginController()),
      builder: (controller) => Container(
        color: bgColor,
        child: TextFormField(
          initialValue: initialValue,
          inputFormatters:
              isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
          keyboardType: keyboardType,
          obscureText: controller.passwordVisibl
              ? !controller.passwordVisibl
              : isPasswordField!,
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              suffixIcon: isPasswordField!
                  ? IconButton(
                      onPressed: () {
                        controller.passwordVisibl = !controller.passwordVisibl;
                      },
                      icon: Icon(controller.passwordVisibl
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    )
                  : null,
              labelText: label,
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  )),
              hintText: hintText,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: 13)),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
