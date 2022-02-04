import 'package:clochard/Screen/mobile/cart_item.dart';
import 'package:clochard/view_Controller/commande_controller.dart';
import 'package:clochard/view_Controller/profil_controller.dart';
import 'package:clochard/widgets/custom_btn.dart';
import 'package:clochard/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'customAppBarMobile.dart';

class PanierScreenMobile extends StatefulWidget {
  @override
  _PanierScreenMobileState createState() => _PanierScreenMobileState();
}

Widget deleteBgItem() {
  return Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 15),
    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.red,
    ),
    height: 80,
    child: Icon(
      Icons.delete,
      color: Colors.white,
    ),
  );
}



class _PanierScreenMobileState extends State<PanierScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMobile(),
      body: SafeArea(
        child: GetBuilder<CommandeController>(
          init: Get.put(CommandeController()),
          builder: (controller) => Column(
            children: [
              Expanded(
                child: ListView.builder(
                    //padding: const EdgeInsets.symmetric(v: ),
                    itemCount: controller.listCommandes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Dismissible(
                            key: Key(UniqueKey().toString()),
                            onDismissed: (direction) {
                              controller.delete(index);
                              //  Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            background: deleteBgItem(),
                            child: CartItemMobile(
                                commande: controller.listCommandes[index])),
                      );
                    }),
              ),
              ToTalPrice(),
            ],
          ),
        ),
      ),
    );
  }
}

class ToTalPrice extends StatefulWidget {
  @override
  _ToTalPriceState createState() => _ToTalPriceState();
}

class _ToTalPriceState extends State<ToTalPrice> {
   Future<void> _alertDialogBuilder() async {
    return showDialog(
        context: context,
          barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: 450,
              height: 200,
              color: Color(0xFF0abf3a),
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "Votre commande a été envoyer",
                  color: Colors.white,fontSize: 20,alignment: Alignment.center,),
                  SizedBox(height: 40,),
                  CustomBtn(
                    width: 200,
                    height: 50,
                    text: "Accueil",
                    bgColor: Colors.black,
                    txtColor: Colors.white,
                    onPressed: (){
                     Get.toNamed("/Home");
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommandeController>(
      init: Get.put(CommandeController()),
      builder: (controller) => Container(
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          children: [
            Text(
              'Total Price : ',
              style: TextStyle(color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                controller.total.toString()+" dt",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600,color:Colors.red),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async{
                   if(FirebaseAuth.instance.currentUser!=null){
                                      if(controller.listCommandes.length!=0){
                                         await controller.setDataInFireBase();
                                         _alertDialogBuilder();
                                      }else{
                                         Get.snackbar(
                                            "erreur", "panier est vide",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            maxWidth: MediaQuery.of(context).size.width * .3,
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10));
                                      }
                                      }else{
                                        Get.snackbar(
                                            "erreur", "veuillez connecter pour passer la commande",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            maxWidth: MediaQuery.of(context).size.width * .3,
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10));
                                      }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Confirmer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
