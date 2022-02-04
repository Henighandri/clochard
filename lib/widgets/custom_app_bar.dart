import 'package:clochard/Screen/Home_screen.dart';
import 'package:clochard/Screen/panier_screen.dart';
import 'package:clochard/Screen/profile_screen.dart';
import 'package:clochard/responsive.dart';
import 'package:clochard/view_Controller/auth_controller/auth_controller.dart';

import 'package:clochard/view_Controller/commande_controller.dart';
import 'package:clochard/view_Controller/home_view_controller.dart';
import 'package:clochard/widgets/auth_widget.dart';
import 'package:clochard/widgets/custom_icon_cart.dart';
import 'package:clochard/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar(
      {Key? key, this.isDetailProduit = false, required this.pressDrawer})
      : super(key: key);
  final bool isDetailProduit;
  final Function()? pressDrawer;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  Future<void> _alertDialogBuilder() async {
    return showDialog(
        context: context,
        useSafeArea: true,
        
        //  barrierDismissible: false,
        builder: (context) {
          return Dialog(
            
            backgroundColor: Colors.transparent,
            child: AuthWidget(),
          );
        });
  }

  @override
  initState() {
    // TODO: implement initState
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Responsive.isTablet(context);
    final bool isMobile = Responsive.isMobile(context);
    return GetBuilder<HomeViewController>(
                init: Get.put(HomeViewController()),
                  builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin:
            EdgeInsets.symmetric(horizontal: isTablet ? 20 : 30, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (!widget.isDetailProduit && (isTablet || isMobile))
                  IconButton(
                      onPressed: widget.pressDrawer,
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                SizedBox(
                  width: isTablet ? 10 : 20,
                ),
                 InkWell(
                    onTap: () {
                      controller.newCollectionSelected=false;
                      controller.getAllCategory(null);
                      //Get.to(HomeScreen());
                      Get.toNamed("/Home");
                    },
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: 40,
                      color: widget.isDetailProduit ? Colors.black : Colors.white,
                    ),
                  ),
                
                SizedBox(
                  width: isTablet ? 20 : 50,
                ),
              
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!widget.isDetailProduit)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width * .35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      onSaved: (value) {},
                      validator: (value) {},
                      onChanged: (value){
                        if(value.isNotEmpty){
                          controller.getAllCategory(value);
                        }else{
                          controller.getAllCategory(null);
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            "Saisissez le nom du produit que vous recherchez ",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: isTablet ? 15 : 40,
                ),
                GetBuilder<CommandeController>(
                  init: Get.put(CommandeController()),
                    builder: (controller) => CustomIconCart(
                        iconColor:
                            widget.isDetailProduit ? Colors.black : Colors.white,
                        numOftItems: controller.listCommandes.length,
                        press: () {
                          Get.toNamed("/Panier");
                        })),
                SizedBox(
                  width: 10,
                ),
                  Obx((){
             
              return (Get.put(AuthController()).user!=null) 
                ?InkWell(
                  onTap: () {
                    Get.toNamed("/MonCompte");
                  },
                  child: Image.asset(
                    "assets/icons/Icon_account.png",
                    color: widget.isDetailProduit ? Colors.black : Colors.white,
                  ),
                )
               : InkWell(
                    onTap: () {
                      _alertDialogBuilder();
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: CustomText(
                      text: "S'identifier",
                      color: widget.isDetailProduit ? Colors.black : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ));
                 }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
