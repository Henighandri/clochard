import 'dart:math';

import 'package:clochard/view_Controller/home_view_controller.dart';

import 'package:clochard/widgets/custom_btn.dart';
import 'package:clochard/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive.dart';

class NewCollection extends StatelessWidget {
  const NewCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Container(
      height: 200,
      padding: isDesktop
          ? EdgeInsets.symmetric(horizontal: 200)
          : EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/new_collection.png",
                  width: 380,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(.2),
                  height: 200,
                  width: 380,
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Nouvelle collection \n2021',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GetBuilder<HomeViewController>(
                        init: Get.put(HomeViewController()),
                        builder: (controller) => CustomBtn(
                          txtColor: Colors.white,
                          width: 150,
                          height: 35,
                          text: "VOIR PLUS",
                          bgColor: Colors.black.withOpacity(.55),
                          isLoading: false,
                          borderColor: Colors.white,
                          fontSize: 12,
                          onPressed: () {
                            controller.newCollectionSelected=true;
                            controller.soldeSelected=false;
                            controller.getNewCollectionMethode();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/solde.png",
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(.2),
                  height: 200,
                  width: 200,
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Solde',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                     GetBuilder<HomeViewController>(
                        init: Get.put(HomeViewController()),
                        builder: (controller) =>  CustomBtn(
                          txtColor: Colors.white,
                          width: 120,
                          height: 35,
                          text: "VOIR PLUS",
                          bgColor: Colors.black.withOpacity(.55),
                          isLoading: false,
                          borderColor: Colors.white,
                          fontSize: 12,
                          onPressed: () {
                            controller.soldeSelected=true;
                            controller.newCollectionSelected=false;
                             controller.getSoldeProduct();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
