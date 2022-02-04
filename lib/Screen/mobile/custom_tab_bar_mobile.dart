import 'package:clochard/view_Controller/home_view_controller.dart';
import 'package:clochard/widgets/custom_botton.dart';
import 'package:clochard/widgets/custom_btn.dart';
import 'package:clochard/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBarMobile extends StatelessWidget {
  const CustomTabBarMobile({ Key? key, required this.onPressDrawer }) : super(key: key);
final Function() onPressDrawer;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewController>(
      init: Get.put(HomeViewController()),
      builder: (controller) => Container(
       margin: EdgeInsets.only(top: 20),
        child:Column(
          children: [
            Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                     controller.setSelectedButton(-1);
                  },
                  child: Container(
                    width: 70,
                    height: 30,
                    color: controller.selected_button==-1?Colors.black: Colors.white,
                    alignment: Alignment.center,
                    child: CustomText(text: "voir tous",fontSize: 12,
                    color: controller.selected_button==-1?Colors.white: Colors.black,
                    alignment: Alignment.center,),
                  ),
                ),
    
                       // IconButton(onPressed: onPressDrawer, icon: Icon(Icons.filter_list))
                        GestureDetector(
                          onTap: onPressDrawer,
                          child: Image.asset("assets/images/icon_filtre.png",width: 30,height: 30,fit: BoxFit.fill,)),
              ],
            ),
            SizedBox(height: 20,),
            if(controller.listCategorie.length!=0)
             Container(
               height: 30,
              
               child: ListView.separated(
                 scrollDirection: Axis.horizontal,
                 itemCount: controller.listCategorie.length,
                 itemBuilder: (context, i) {
                   return GestureDetector(
                     onTap: (){
                            controller.setSelectedButton(i);
                     },
                     child: Text.rich(
                     TextSpan(
                       text: controller.listCategorie[i].text.toString(),
                       style: TextStyle(color: controller.selected_button==i?Colors.black: Colors.grey,
                       fontWeight: controller.selected_button==i?FontWeight.bold:FontWeight.normal
                       ),
                       children: [
                         TextSpan(
                 text: ' (${controller.listCategorie[i].listProduits!.length})',
                 style: TextStyle(color: Colors.grey),
               ),
                       ]
                     )
                   ),
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
        )
        
      ),
    );
  }
}