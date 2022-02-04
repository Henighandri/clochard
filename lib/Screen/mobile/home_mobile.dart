import 'package:clochard/view_Controller/home_view_controller.dart';
import 'package:clochard/widgets/category.dart';
import 'package:clochard/widgets/custom_filtre.dart';
import 'package:clochard/widgets/custom_tab_bar.dart';
import 'package:clochard/widgets/gridview_product.dart';
import 'package:clochard/widgets/products_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'customAppBarMobile.dart';
import 'custom_tab_bar_mobile.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  _HomeMobileState createState() => _HomeMobileState();
}
final DateTime now = DateTime.now();
class _HomeMobileState extends State<HomeMobile> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewController>(
      init: Get.put(HomeViewController()),
      builder: (controller) => Scaffold(
        key: _scafoldKey,
        drawer: CustomFiltre(),
        appBar: CustomAppBarMobile(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
               AssetImage("assets/icons/sold.png"),
                    //color: Color(0xFF3A5A98),
               ),
              label: 'Nouvelle collection',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
               AssetImage("assets/icons/sold.png"),
                    //color: Color(0xFF3A5A98),
               ),
              label: 'Solde',
            ),
          ],
          currentIndex: controller.selected_buttonNavigationBar,
          selectedItemColor: Colors.black,
          onTap: (index) {
            controller.selected_buttonNavigationBar = index;
            if (index == 0) {
              controller.soldeSelected = false;
              controller.newCollectionSelected = false;
              controller.getAllCategory(null);
            } else if (index == 1) {
              controller.newCollectionSelected = true;
              controller.soldeSelected = false;
              controller.getNewCollectionMethode();
            } else if (index == 2) {
              controller.soldeSelected = true;
              controller.newCollectionSelected = false;
              controller.getSoldeProduct();
            }
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: controller.listCategorie.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTabBarMobile(
                          onPressDrawer: () {
                            _scafoldKey.currentState!.openDrawer();
                          },
                        ),
                         if (controller.newCollectionSelected)
            CollectionOrSolde(
                text: 'Nouvelle collection \n ${now.year}',
                image: "assets/images/new_collection.png"),
                 if (controller.soldeSelected)
            CollectionOrSolde(
                text: 'Solde',
                image: "assets/images/solde2.png"),
                        if (controller.selected_button == -1)
                          for (int i = 0;
                              i < controller.listCategorie.length;
                              i++)
                            if (controller
                                    .listCategorie[i].listProduits!.length !=
                                0)
                              Category(
                                showFlesh: false,
                                idCategory: controller
                                    .listCategorie[i].idCategorie
                                    .toString(),
                                categorieName:
                                    controller.listCategorie[i].text.toString(),
                                listProduits:
                                    controller.listCategorie[i].listProduits,
                              ),
                        if (controller.selected_button != -1)
                          GridViewProduct(
                            idCategory: controller
                                .listCategorie[controller.selected_button]
                                .idCategorie
                                .toString(),
                            categorieName: controller
                                .listCategorie[controller.selected_button].text
                                .toString(),
                            listProduits: controller
                                .listCategorie[controller.selected_button]
                                .listProduits,
                          ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
