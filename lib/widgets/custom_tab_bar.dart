import 'package:clochard/view_Controller/home_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'custom_botton.dart';

class CustomTabBar extends StatelessWidget {
  CustomTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewController>(
      init: Get.put(HomeViewController()),
      builder: (controller) => Container(
        height: 35,
        
        width: 600,
        // padding: EdgeInsets.only(right: 200),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  controller.soldeSelected = false;
                  controller.newCollectionSelected = false;
                  controller.getAllCategory(null);
                },
                child: Icon(
                  Icons.home,
                  size: 35,
                )),
            SizedBox(
              width: 20,
            ),
            CustomButton(
              text: "Voir Tout",
              bgColor: controller.selected_button == -1
                  ? Colors.black
                  : Colors.white,
              txColor: controller.selected_button == -1
                  ? Colors.white
                  : Colors.black,
              width: 100,
              onPress: () {
                controller.setSelectedButton(-1);
              },
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.listCategorie.length,
                itemBuilder: (context, i) {
                  return CustomButton(
                    text: controller.listCategorie[i].text.toString(),
                    bgColor: controller.selected_button == i
                        ? Colors.black
                        : Colors.white,
                    txColor: controller.selected_button == i
                        ? Colors.white
                        : Colors.black,
                    width: 100,
                    onPress: () {
                      controller.setSelectedButton(i);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 10,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
