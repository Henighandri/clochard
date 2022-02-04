
import 'package:clochard/view_Controller/home_view_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

class CustomFiltre extends StatelessWidget {
  CustomFiltre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,

          child: GetBuilder<HomeViewController>(
            init: Get.put(HomeViewController()),
      builder: (controller) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
         padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Image.asset("assets/images/icon_filtre.png",width: 40,height: 40,),
            ],
          ),
          categoryMethod(context, controller),
          prixMethod(context, controller),
          tailleMethod(context, controller),
          SizedBox(
            height: 50,
          )
          ],
            ),
      ),
          ),
    );
  }

  Container categoryMethod(BuildContext context, HomeViewController controller) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * .25,
      height: 250,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          CustomText(
            text: 'Categories',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: controller.listCategorie.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    activeColor: Colors.black,

                    title:Text.rich(
                      TextSpan(
                        text: controller.listCategorie[index].text.toString(),
                        children: [
                          TextSpan(
                  text: ' (${controller.listCategorie[index].listProduits!.length})',
                  style: TextStyle(color: Colors.grey),
                ),
                        ]
                      )
                    ),
                       // Text(controller.listCategorie[index].text.toString()),
                    value: controller.selected_button==index,
                    onChanged: (newValue) {
                      controller.setSelectedButton(index);
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  );
                }),
          )
        ],
      ),
    );
  }

  Container prixMethod(BuildContext context, HomeViewController controller) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * .25,
      height: 150,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
      child: Column(children: [
        SizedBox(
          height: 40,
        ),
        CustomText(
          text: 'Prix DT',
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        RangeSlider(
          activeColor: Colors.black,
          values: controller.currentRangeValues,
          min: 0,
          max: 500,
          divisions: 50,
          labels: controller.rangeLabels,
          onChanged: (RangeValues values) {
            controller.currentRangeValues = values;
            controller.setrangeLabels();
          },
        ),
      ]),
    );
  }

  Container tailleMethod(BuildContext context, HomeViewController controller) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * .25,
      height: 150,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
      child: Column(children: [
        SizedBox(
          height: 40,
        ),
        CustomText(
          text: 'Taille',
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.tailles.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (controller.selected_taille != index) {
                            controller.selected_taille = index;
                          }else{
                             controller.selected_taille =null;
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: controller.selected_taille == index
                                      ? Colors.red
                                      : Colors.grey)),
                          child: Text(
                            controller.tailles[index],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
