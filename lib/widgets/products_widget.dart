import 'package:clochard/view_Controller/home_view_controller.dart';

import 'package:clochard/widgets/gridview_product.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive.dart';
import 'category.dart';
import 'custom_tab_bar.dart';
import 'custom_text.dart';

class ProductsWidget extends StatelessWidget {
  ProductsWidget({
    Key? key, 
  }) : super(key: key);
final DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewController>(
      init: Get.put(HomeViewController()),
      builder: (controller) => controller.loading.value
      ?Center(child: CircularProgressIndicator(),) 
      :Column(
        children: [
          CustomTabBar(),
          if (controller.newCollectionSelected)
            CollectionOrSolde(
                text: 'Nouvelle collection \n ${now.year}',
                image: "assets/images/new_collection.png"),
                 if (controller.soldeSelected)
            CollectionOrSolde(
                text: 'Solde',
                image: "assets/images/solde2.png"),
          if (controller.selected_button == -1)
            for (int i = 0; i < controller.listCategorie.length; i++)
              if (controller.listCategorie[i].listProduits!.length != 0)
                Category(
                  idCategory: controller.listCategorie[i].idCategorie.toString(),
                  categorieName: controller.listCategorie[i].text.toString(),
                  listProduits: controller.listCategorie[i].listProduits,
                ),
          if (controller.selected_button != -1)
            GridViewProduct(
              idCategory: controller.listCategorie[controller.selected_button].idCategorie.toString(),
              categorieName: controller
                  .listCategorie[controller.selected_button].text
                  .toString(),
              listProduits: controller
                  .listCategorie[controller.selected_button].listProduits, 
            ),
        ],
      ),
    );
  }
}

class CollectionOrSolde extends StatelessWidget {
  const CollectionOrSolde({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text;
  final String? image;
  @override
  Widget build(BuildContext context) {
     final bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: isMobile ? 0: 40, vertical:isMobile ?10: 30),
      child: Stack(children: [
        Image.asset(
          image.toString(),
          width:isMobile?MediaQuery.of(context).size.width: MediaQuery.of(context).size.width * .8,
          height: isMobile?150: 200,
          fit: BoxFit.cover,
        ),
        Container(
            color: Colors.black.withOpacity(.2),
            height:isMobile?150: 200,
            width:isMobile?MediaQuery.of(context).size.width: MediaQuery.of(context).size.width * .8,
            padding: EdgeInsets.only(left: 30),
            child: CustomText(
              text: text.toString(),
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ]),
    );
  }
}
