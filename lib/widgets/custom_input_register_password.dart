
import 'package:clochard/view_Controller/auth_controller/register_controller.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputRegisterPassword extends StatelessWidget {
  final String? hintText;
 final String? label;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool? isEmailField;
  final bool? isPasswordField;

  const CustomInputRegisterPassword(
      {Key? key,
      this.hintText='',
      this.onChanged,
      this.textInputAction,
      this.isPasswordField,
      this.isEmailField,
      this.onSaved,
      this.validator, this.label,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
    
      builder: (controller) => Container(
        color: Colors.white,
              child: TextFormField(
          keyboardType: isEmailField! ? TextInputType.emailAddress : null,
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
                  borderSide: BorderSide(color: Colors.grey,)),
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 13)),
              
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
