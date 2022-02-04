import 'package:clochard/Screen/mobile/registre_mobile_screen.dart';
import 'package:clochard/view_Controller/auth_controller/login_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../responsive.dart';
import 'custom_btn.dart';
import 'custom_input.dart';
import 'custom_text.dart';
import 'form_errors.dart';

class Login_widget extends StatelessWidget {
  Login_widget({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    return GetBuilder<LoginController>(
        init: Get.put(LoginController()),
        builder: (controller) => Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              height: isMobile
                  ? MediaQuery.of(context).size.height
                  : isTablet
                      ? MediaQuery.of(context).size.height * .5
                      : MediaQuery.of(context).size.height * .7,
              color: Colors.black,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: "Connectez-vous",
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        alignment: Alignment.center,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildCustomInputEmail(controller),
                          SizedBox(
                            height: 20,
                          ),
                          buildCustomInputPassword(controller),
                          SizedBox(
                            height: isMobile ? 20 : 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    _formKey.currentState!.save();

                                    if (controller.signInEmail.isEmpty) {
                                      controller
                                          .clearError(controller.errorsSignIn);
                                      controller.addError(
                                          controller.errorsSignIn,
                                          kEmailNullError);
                                    } else {
                                      controller.resetPassword();
                                    }
                                  },
                                  child: Container(
                                      height: 25,
                                      child: CustomText(
                                        text: "Mot de passe oublié ?",
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      )))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormError(errors: controller.errorsSignIn),
                          SizedBox(
                            height: 10,
                          ),
                          CustomBtn(
                            text: "connexion",
                            bgColor: Color(0xFFFBB03B),
                            txtColor: Colors.black,
                            isLoading: controller.registerFormLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                controller.signInethod();
                              }
                              //
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (isMobile)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: "Première visite sur Clochard ?",
                                  color: Colors.white,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(RegistreScreenMobile());
                                    },
                                    child: CustomText(
                                        text: "Inscrivez-vous",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      InkWell(
                          onTap: () {
                            controller.clearError(controller.errorsSignIn);
                            Get.back();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                              CustomText(
                                text: "Back",
                                color: Colors.white,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ));
  }

  CustomInput buildCustomInputPassword(LoginController controller) {
    return CustomInput(
      hintText: "Entre votre mot de passe",
      isPasswordField: true,
      keyboardType: TextInputType.name,
      onSaved: (newValue) {
        controller.signInPassword = newValue.toString();
      },
      onChanged: (value) {
        if (value.isNotEmpty &&
            controller.errorsSignIn.contains(kPassNullError)) {
          controller.removeError(controller.errorsSignIn, kPassNullError);
        } else if (value.length >= 8 &&
            controller.errorsSignIn.contains(kShortPassError)) {
          controller.removeError(controller.errorsSignIn, kShortPassError);
        }
        return true;
      },
      validator: (value) {
        if (value!.isEmpty &&
            !controller.errorsSignIn.contains(kPassNullError)) {
          controller.addError(controller.errorsSignIn, kPassNullError);

          // return "";
        } else if (value.length < 8 &&
            !controller.errorsSignIn.contains(kShortPassError)) {
          controller.addError(controller.errorsSignIn, kShortPassError);

          // return "";
        }
        return null;
      },
    );
  }

  CustomInput buildCustomInputEmail(LoginController controller) {
    return CustomInput(
      isPasswordField: false,
      keyboardType: TextInputType.emailAddress,
      hintText: 'Entre votre Email',
      textInputAction: TextInputAction.next,
      onSaved: (newValue) {
        controller.signInEmail = newValue.toString();
      },
      onChanged: (value) {
        if (value.isNotEmpty &&
            controller.errorsSignIn.contains(kEmailNullError)) {
          controller.removeError(controller.errorsSignIn, kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value) &&
            controller.errorsSignIn.contains(kInvalidEmailError)) {
          controller.removeError(controller.errorsSignIn, kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty &&
            !controller.errorsSignIn.contains(kEmailNullError)) {
          controller.addError(controller.errorsSignIn, kEmailNullError);

          //  return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !controller.errorsSignIn.contains(kInvalidEmailError)) {
          controller.addError(controller.errorsSignIn, kInvalidEmailError);

          //   return "";
        }
        return null;
      },
    );
  }
}
