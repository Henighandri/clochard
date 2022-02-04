import 'dart:async';


import 'package:clochard/view_Controller/auth_controller/register_controller.dart';


import 'package:clochard/widgets/custom_input_register_password.dart';
import 'package:clochard/widgets/form_errors.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../responsive.dart';
import 'custom_btn.dart';
import 'custom_input.dart';
import 'custom_text.dart';
import 'email_verification.dart';


class RegisterWidget extends StatefulWidget {
  RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _emailVerifiedDialogue() async {
    return showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              content: EmailVerification(),
              );
        });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
     final bool isTablet = Responsive.isTablet(context);
        final bool isDesktop = Responsive.isDesktop(context);
    return GetBuilder<RegisterController>(
      init: Get.put(RegisterController()),
      builder: (controller) => Container(
        height:isMobile ?MediaQuery.of(context).size.height :isTablet? MediaQuery.of(context).size.height * .5:MediaQuery.of(context).size.height * .7,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: "Première visite sur Clochard",
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 30,
                ),
                isDesktop
                ?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCustomInputNom(controller,isMobile),
                        buildCustomInputEmail(controller,isMobile),
                        buildCustomInputPassword(controller,isMobile),
                        buildCustomInputaAdresse(controller,isMobile),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCustomInputPrenom(controller,isMobile),
                        buildCustomInputRegion(controller,isMobile),
                        buildCustomInputTel(controller,isMobile),
                        buildCustomInputCodePostal(controller,isMobile),
                      ],
                    )
                  ],
                )
                 :Column(
                  
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCustomInputNom(controller,isMobile),
                        buildCustomInputEmail(controller,isMobile),
                        buildCustomInputPassword(controller,isMobile),
                        buildCustomInputaAdresse(controller,isMobile),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCustomInputPrenom(controller,isMobile),
                        buildCustomInputRegion(controller,isMobile),
                        buildCustomInputTel(controller,isMobile),
                        buildCustomInputCodePostal(controller,isMobile),
                      ],
                    )
                  ],
                ),
                FormError(
                    errors: controller.errorsSignUp, txtColor: Colors.black),
                CustomBtn(
                  txtColor: Colors.black,
                  text: "S'inscrire",
                  bgColor: Color(0xFFFBB03B),
                  isLoading: controller.registerFormLoading,
                  onPressed: () async {
                    _formKey.currentState!.validate();
                    if (controller.errorsSignUp.length == 0) {
                      _formKey.currentState!.save();
                      await controller.creatUser();

                      Navigator.pop(context);
                      _emailVerifiedDialogue();
                   }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCustomInputEmail(RegisterController controller,bool isMobile) {
    return Container(
      width:isMobile?Get.size.width: 250,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        isPasswordField: false,
        keyboardType: TextInputType.emailAddress,
        label: 'Email',
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.registerEmail = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsSignUp.contains(kEmailNullError)) {
            controller.removeError(controller.errorsSignUp, kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value) &&
              controller.errorsSignUp.contains(kInvalidEmailError)) {
            controller.removeError(controller.errorsSignUp, kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsSignUp.contains(kEmailNullError)) {
            controller.addError(controller.errorsSignUp, kEmailNullError);

            //  return "";
          } else if (!emailValidatorRegExp.hasMatch(value) &&
              !controller.errorsSignUp.contains(kInvalidEmailError)) {
            controller.addError(controller.errorsSignUp, kInvalidEmailError);

            //   return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputNom(RegisterController controller,bool isMobile) {
    return Container(
      width: isMobile?Get.size.width: 250,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        isPasswordField: false,
        keyboardType: TextInputType.name,
        label: 'Nom',
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.nom = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsSignUp.contains(kNamelNullError)) {
            controller.removeError(controller.errorsSignUp, kNamelNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsSignUp.contains(kNamelNullError)) {
            controller.addError(controller.errorsSignUp, kNamelNullError);

            //  return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputPassword(RegisterController controller,bool isMobile) {
    return Container(
      width: isMobile?Get.size.width: 250,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInputRegisterPassword(
        label: "Mot de passe",
        isPasswordField: true,
        isEmailField: false,
        onSaved: (newValue) {
          controller.registerPassword = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsSignUp.contains(kPassNullError)) {
            controller.removeError(controller.errorsSignUp, kPassNullError);
          } else if (value.length >= 8 &&
              controller.errorsSignUp.contains(kShortPassError)) {
            controller.removeError(controller.errorsSignUp, kShortPassError);
          }
          return true;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsSignUp.contains(kPassNullError)) {
            controller.addError(controller.errorsSignUp, kPassNullError);

            // return "";
          } else if (value.length < 8 &&
              !controller.errorsSignUp.contains(kShortPassError)) {
            controller.addError(controller.errorsSignUp, kShortPassError);

            // return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputPrenom(RegisterController controller,bool isMobile) {
    return Container(
      width:  isMobile?Get.size.width: 250,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        isPasswordField: false,
        keyboardType: TextInputType.name,
        label: 'Prénom',
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.prenom = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsSignUp.contains(kPrenomNullError)) {
            controller.removeError(controller.errorsSignUp, kPrenomNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsSignUp.contains(kPrenomNullError)) {
            controller.addError(controller.errorsSignUp, kPrenomNullError);

            //  return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputaAdresse(RegisterController controller,bool isMobile) {
    return Container(
      width:  isMobile?Get.size.width: 250,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        isPasswordField: false,
        keyboardType: TextInputType.emailAddress,
        label: 'Adresse',
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.adresse = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsSignUp.contains(kAddressNullError)) {
            controller.removeError(controller.errorsSignUp, kAddressNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsSignUp.contains(kAddressNullError)) {
            controller.addError(controller.errorsSignUp, kAddressNullError);

            //  return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputTel(RegisterController controller,bool isMobile) {
    return Container(
      width:  isMobile?Get.size.width: 250,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        isPasswordField: false,
        isNumber: true,
        keyboardType: TextInputType.phone,
        label: 'Numero de téléphone',
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.tel = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsSignUp.contains(kShorPhoneNumberError)) {
            controller.removeError(
                controller.errorsSignUp, kShorPhoneNumberError);
          } else if (value.length == 8 &&
              controller.errorsSignUp.contains(kShorPhoneNumberError)) {
            controller.removeError(
                controller.errorsSignUp, kShorPhoneNumberError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsSignUp.contains(kShorPhoneNumberError)) {
            controller.addError(controller.errorsSignUp, kShorPhoneNumberError);

            // return "";
          } else if (value.length != 8 &&
              !controller.errorsSignUp.contains(kShorPhoneNumberError)) {
            controller.addError(controller.errorsSignUp, kShorPhoneNumberError);

            // return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputCodePostal(RegisterController controller,bool isMobile) {
    return Container(
      width:  isMobile?Get.size.width: 250,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        isPasswordField: false,
        isNumber: true,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        label: 'Code Postal',
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.codePostal = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsSignUp.contains(kCodePostalNull)) {
            controller.removeError(controller.errorsSignUp, kCodePostalNull);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsSignUp.contains(kCodePostalNull)) {
            controller.addError(controller.errorsSignUp, kCodePostalNull);

            //  return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputRegion(RegisterController controller,bool isMobile) {
    return Container(
      width:  isMobile?Get.size.width: 250,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        isPasswordField: false,
        keyboardType: TextInputType.name,
        label: 'Region',
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.region = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsSignUp.contains(kRegionNull)) {
            controller.removeError(controller.errorsSignUp, kRegionNull);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsSignUp.contains(kRegionNull)) {
            controller.addError(controller.errorsSignUp, kRegionNull);

            //  return "";
          }
          return null;
        },
      ),
    );
  }
}
