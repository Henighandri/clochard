import 'package:clochard/view_Controller/profil_controller.dart';
import 'package:clochard/widgets/custom_btn.dart';
import 'package:clochard/widgets/custom_input.dart';
import 'package:clochard/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants.dart';
import 'cart_item.dart';
import 'customAppBarMobile.dart';

class ProfilScreenMobile extends StatelessWidget {
  ProfilScreenMobile({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilController>(
      init: Get.put(ProfilController()),
      builder: (controller) => Scaffold(
        appBar: CustomAppBarMobile(),
        body: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
         // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //height: 250,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CustomBtn(
                        width: 180,
                        height: 50,
                        txtColor: !controller.historiqueSelected
                            ? Colors.white
                            : Colors.black,
                        text: "Profile",
                        bgColor: !controller.historiqueSelected
                            ? Colors.black
                            : Colors.white,
                        isLoading: false,
                        onPressed: () {
                          controller.getInformationUser();
                          controller.historiqueSelected = false;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomBtn(
                        width: 180,
                        height: 50,
                        txtColor: controller.historiqueSelected
                            ? Colors.white
                            : Colors.black,
                        text: "historique",
                        bgColor: controller.historiqueSelected
                            ? Colors.black
                            : Colors.white,
                        isLoading: false,
                        onPressed: () {
                          controller.getHistorigue();

                          controller.historiqueSelected = true;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomBtn(
                        width: 180,
                        height: 50,
                        txtColor: Colors.black,
                        text: "déconnexion",
                        bgColor: Colors.white,
                        isLoading: false,
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Get.offAllNamed("/Home");
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: QrImage(
                      data: FirebaseAuth.instance.currentUser!.uid,
                      size: 130,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            !controller.historiqueSelected
                ? controller.registerFormLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,

                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: "Nom",
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  buildCustomInputNom(controller),
                                  CustomText(
                                    text: "Adresse",
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  buildCustomInputaAdresse(controller),
                                  CustomText(
                                    text: "E-mail",
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  buildCustomInputEmail(controller),
                                  CustomText(
                                    text: "Code Postale",
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  buildCustomInputCodePostal(controller),
                                  CustomText(
                                    text: "Prénom",
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  buildCustomInputPrenom(controller),
                                  CustomText(
                                    text: "Region",
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  buildCustomInputRegion(controller),
                                  CustomText(
                                    text: "Numéro de téléphone",
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  buildCustomInputTel(controller),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: CustomBtn(
                                          txtColor: Colors.white,
                                          text: "CHANGER",
                                          bgColor: Colors.black,
                                          isLoading:
                                              controller.registerFormLoading,
                                          onPressed: () async {
                                            _formKey.currentState!.validate();
                                            if (controller
                                                    .errorsProfile.length ==
                                                0) {
                                              _formKey.currentState!.save();
                                              await controller
                                                  .changeUserInformation();
                                              Get.snackbar("",
                                                  "votre compte modifié avec succès",
                                                  backgroundColor:
                                                      Color(0xFF0abf3a),
                                                  colorText: Colors.white,
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .3,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10));
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,)
                                ],
                              ),
                            ),
                          ),
                      ),
                    )
                :Expanded(
                  child: ListView.builder(
             // shrinkWrap: true,
              //padding: const EdgeInsets.symmetric(v: ),
                    itemCount: controller.listCommande.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: CartItemMobile(
                            commande: controller.listCommande[index]),
                      );
                    }),
                ),

          ],
        ),
      ),
    );
  }

  Widget buildCustomInputEmail(ProfilController controller) {
    return Container(
        width: 300,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.grey)),
        margin: EdgeInsets.only(top: 10, bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: CustomText(
          text: controller.email,
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ));
  }

  Widget buildCustomInputNom(ProfilController controller) {
    return Container(
      width: 300,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        bgColor: Color(0xFFF),
        isPasswordField: false,
        keyboardType: TextInputType.name,
        initialValue: controller.nom.toString(),
        label: null,
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.nom = newValue;
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsProfile.contains(kNamelNullError)) {
            controller.removeError(kNamelNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsProfile.contains(kNamelNullError)) {
            controller.addError(kNamelNullError);

            //  return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputPrenom(ProfilController controller) {
    return Container(
      width: 300,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        bgColor: Color(0xFFF),
        isPasswordField: false,
        keyboardType: TextInputType.name,
        initialValue: controller.prenom.toString(),
        label: null,
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.prenom = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsProfile.contains(kPrenomNullError)) {
            controller.removeError(kPrenomNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsProfile.contains(kPrenomNullError)) {
            controller.addError(kPrenomNullError);

            //  return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputaAdresse(ProfilController controller) {
    return Container(
      width: 300,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        bgColor: Color(0xFFF),
        isPasswordField: false,
        keyboardType: TextInputType.emailAddress,
        initialValue: controller.adresse.toString(),
        label: null,
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.adresse = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsProfile.contains(kAddressNullError)) {
            controller.removeError(kAddressNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsProfile.contains(kAddressNullError)) {
            controller.addError(kAddressNullError);

            //  return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputTel(ProfilController controller) {
    return Container(
      width: 300,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        bgColor: Color(0xFFF),
        isPasswordField: false,
        isNumber: true,
        keyboardType: TextInputType.phone,
        initialValue: controller.tel.toString(),
        label: null,
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.tel = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsProfile.contains(kShorPhoneNumberError)) {
            controller.removeError(kShorPhoneNumberError);
          } else if (value.length == 8 &&
              controller.errorsProfile.contains(kShorPhoneNumberError)) {
            controller.removeError(kShorPhoneNumberError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsProfile.contains(kShorPhoneNumberError)) {
            controller.addError(kShorPhoneNumberError);

            // return "";
          } else if (value.length != 8 &&
              !controller.errorsProfile.contains(kShorPhoneNumberError)) {
            controller.addError(kShorPhoneNumberError);

            // return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputCodePostal(ProfilController controller) {
    return Container(
      width: 300,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        bgColor: Color(0xFFF),
        isPasswordField: false,
        isNumber: true,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        initialValue: controller.codePostal.toString(),
        label: null,
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.codePostal = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsProfile.contains(kCodePostalNull)) {
            controller.removeError(kCodePostalNull);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsProfile.contains(kCodePostalNull)) {
            controller.addError(kCodePostalNull);

            //  return "";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCustomInputRegion(ProfilController controller) {
    return Container(
      width: 300,
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: CustomInput(
        bgColor: Color(0xFFF),
        isPasswordField: false,
        keyboardType: TextInputType.name,
        initialValue: controller.region.toString(),
        label: null,
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          controller.region = newValue.toString();
        },
        onChanged: (value) {
          if (value.isNotEmpty &&
              controller.errorsProfile.contains(kRegionNull)) {
            controller.removeError(kRegionNull);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty &&
              !controller.errorsProfile.contains(kRegionNull)) {
            controller.addError(kRegionNull);

            //  return "";
          }
          return null;
        },
      ),
    );
  }
}
