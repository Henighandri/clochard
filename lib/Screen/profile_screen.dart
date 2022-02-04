import 'package:clochard/Screen/Home_screen.dart';
import 'package:clochard/Screen/detail_screen.dart';
import 'package:clochard/helper/extension.dart';
import 'package:clochard/model/commande.dart';
import 'package:clochard/view_Controller/profil_controller.dart';
import 'package:clochard/widgets/custom_app_bar.dart';
import 'package:clochard/responsive.dart';
import 'package:clochard/widgets/custom_btn.dart';
import 'package:clochard/widgets/custom_input.dart';
import 'package:clochard/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../constants.dart';
import 'mobile/cart_item.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // Get.put(ProfilController());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isTablet = Responsive.isTablet(context);
        return Scaffold(
    body: GetBuilder<ProfilController>(
    init: Get.put(ProfilController()),
    builder: (controller) => Column(
    children: [
    CustomAppBar(
    isDetailProduit: true,
    pressDrawer: () {},
    ),
    Container(
    width: size.width * .8,
    height: size.height * .8,
    color: Color(0xFFD8D8D8),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: "Mon Compte",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              SizedBox(
                height: 40,
              ),
          CustomBtn(
            width: 200,
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
            width: 200,
            height: 50,
            txtColor: controller.historiqueSelected
                ? Colors.white
                : Colors.black,
            text: "historique",
            bgColor: controller.historiqueSelected
                ? Colors.black
                : Colors.white,
            isLoading: false,
            onPressed: ()  {
             
              controller.getHistorigue();
            
              controller.historiqueSelected = true;
               
            },
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.center,
            child: QrImage(
              data: FirebaseAuth.instance.currentUser!.uid,
              size: 135,
              backgroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: CustomBtn(
                width: 200,
                height: 50,
                txtColor: Colors.white,
                text: "déconnexion",
                bgColor: Colors.black,
                isLoading: controller.registerFormLoading,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                 Get.offAllNamed("/Home");
                },
              ),
            ),
          )
        ],
      ),
    ),
    Expanded(
      child:!controller.historiqueSelected
      ? Container(
        margin:
            EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/profileIcon.png",
                  width: 70,
                  height: 70,
                ),
                controller.registerFormLoading
                    ? Center(child: CircularProgressIndicator())
                    :!isTablet
                      ? Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
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
                              buildCustomInputCodePostal(
                                  controller),
                            ],
                          ),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
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
                              Container(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 200,
                                      child: CustomBtn(
                                        txtColor: Colors.white,
                                        text: "CHANGER",
                                        bgColor: Colors.black,
                                        isLoading: controller
                                            .registerFormLoading,
                                        onPressed: () async {
                                          _formKey.currentState!
                                              .validate();
                                          if (controller
                                                  .errorsProfile
                                                  .length ==
                                              0) {
                                            _formKey.currentState!
                                                .save();
                                            await controller
                                                .changeUserInformation();
                                            Get.snackbar("",
                                                "votre compte modifié avec succès",
                                                backgroundColor:
                                                    Color(
                                                        0xFF0abf3a),
                                                colorText:
                                                    Colors.white,
                                                maxWidth: MediaQuery.of(
                                                            context)
                                                        .size
                                                        .width *
                                                    .3,
                                                padding: EdgeInsets
                                                    .symmetric(
                                                        horizontal:
                                                            20,
                                                        vertical:
                                                            10));
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ): Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
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
                              buildCustomInputCodePostal(
                                  controller),
                       
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
                              Container(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 200,
                                      child: CustomBtn(
                                        txtColor: Colors.white,
                                        text: "CHANGER",
                                        bgColor: Colors.black,
                                        isLoading: controller
                                            .registerFormLoading,
                                        onPressed: () async {
                                          _formKey.currentState!
                                              .validate();
                                          if (controller
                                                  .errorsProfile
                                                  .length ==
                                              0) {
                                            _formKey.currentState!
                                                .save();
                                            await controller
                                                .changeUserInformation();
                                            Get.snackbar("",
                                                "votre compte modifié avec succès",
                                                backgroundColor:
                                                    Color(
                                                        0xFF0abf3a),
                                                colorText:
                                                    Colors.white,
                                                maxWidth: MediaQuery.of(
                                                            context)
                                                        .size
                                                        .width *
                                                    .3,
                                                padding: EdgeInsets
                                                    .symmetric(
                                                        horizontal:
                                                            20,
                                                        vertical:
                                                            10));
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
          
              ],
            ),
          ),
        ),
      )
      :controller.listCommande.length!=0
          ?isTablet
            ?ListView.builder(
                //padding: const EdgeInsets.symmetric(v: ),
                itemCount: controller.listCommande.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: CartItemMobile(
                        commande: controller.listCommande[index]),
                  );
                })
            
            :Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: DataTable(
                         
                        dataRowHeight: MediaQuery.of(context).size.width *0.07,
                            horizontalMargin: 10,
                            columnSpacing: 20,
                            columns: [
                              DataColumn(
                                label: Text("Produit",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey)),
                              ),
                              DataColumn(
                                label: Text("Couleur",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey))),
                              DataColumn(
                                label: Text("Taille",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey)),
                              ),
                              DataColumn(
                                label: Text("Quantité",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey)),
                              ),
                              DataColumn(
                                label: Text("Prix",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey)),
                              ),
                             
                            ],
                            rows: List.generate(
                              controller.listCommande.length,
                              (index) => recentFileDataRow(
                                  index, context,controller ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
            ):Center(child: CircularProgressIndicator(),)
    )
  ],
),
)
],
),
),
);
  }

  DataRow recentFileDataRow(int index, BuildContext context,ProfilController controller ) {
    Commande commande=controller.listCommande[index];

    return DataRow(
      
      cells: [
        DataCell(
        
          Container(
             padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Image.network(
                    commande.produit!.images![0],
                    height: 100,
                    width: 90,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text:commande.produit!.name.toString(),fontSize: 15, fontWeight: FontWeight.w600,maxLines: 1,),
                     SizedBox(height: 10,),
                      CustomText(text: commande.date.toString(),color: Colors.grey,fontSize: 12,),
                    ],
                  ),
             
                ],
              ),
            ),
        
        ),
        DataCell(
          Container(width: 30,height: 30,color: HexColor.fromHex(commande.color.toString())),
          ),
        DataCell(Text(commande.size!,style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
        DataCell(
          Text(controller.listCommande[index].quantity.toString(),style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
        ),
        DataCell(Text(commande.prix.toString(),style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),)),
       
      ],
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
        bgColor: Color(0xFFD8D8D8),
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
        bgColor: Color(0xFFD8D8D8),
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
        bgColor: Color(0xFFD8D8D8),
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
        bgColor: Color(0xFFD8D8D8),
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
        bgColor: Color(0xFFD8D8D8),
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
        bgColor: Color(0xFFD8D8D8),
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
