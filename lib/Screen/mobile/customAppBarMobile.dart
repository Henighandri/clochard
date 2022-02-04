
import 'package:clochard/Screen/mobile/login_mobile_screen.dart';
import 'package:clochard/Screen/mobile/profil_mobile_screen.dart';
import 'package:clochard/view_Controller/auth_controller/auth_controller.dart';
import 'package:clochard/view_Controller/commande_controller.dart';
import 'package:clochard/widgets/custom_icon_cart.dart';
import 'package:clochard/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarMobile extends StatelessWidget with PreferredSizeWidget {
    @override
    final Size preferredSize;

  

    CustomAppBarMobile(
      
        { Key? key,}) : preferredSize = Size.fromHeight(50.0),
            super(key: key);

    @override
    Widget build(BuildContext context) {
        return AppBar(
        
        backgroundColor: Colors.transparent,
        elevation: 0,
        
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black)),
          
           GetBuilder<CommandeController>(
                  init: Get.put(CommandeController()),
                    builder: (controller) => CustomIconCart(
                        iconColor:
                             Colors.black ,
                        numOftItems: controller.listCommandes.length,
                        press: () {
                          Get.toNamed("/Panier");
                        })),
            Obx((){
             
              return (Get.find<AuthController>().user==null) 
              ? GestureDetector(
                onTap: (){
                  Get.to(LoginMobileScreen());
                },
                child: CustomText(text: "S'inscrire    ",color: Colors.black,fontWeight: FontWeight.w600,))
              :IconButton(
                onPressed: (){Get.toNamed("/MonCompte");},
               icon: ImageIcon(
               AssetImage("assets/icons/Icon_account.png"),
                   color: Colors.black,
               ),);
             } ),
        
        ],
        leading:IconButton(onPressed: (){
            Get.back();
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,))
       
      );
    }
}