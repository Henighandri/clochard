import 'package:clochard/Screen/detail_screen.dart';
import 'package:clochard/model/produit.dart';
import 'package:clochard/view_Controller/commande_controller.dart';
import 'package:clochard/view_Controller/home_view_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive.dart';
import 'custom_text.dart';

class GridViewProduct extends StatelessWidget {
  GridViewProduct(
      {Key? key,
      this.listProduits,
      required this.categorieName,
      required this.idCategory})
      : super(key: key);
  final List<Produit>? listProduits;
  final String categorieName;
  final String idCategory;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = Responsive.isTablet(context);
     final bool isMobile = Responsive.isMobile(context);
    return GetBuilder<CommandeController>(
        init: Get.put(CommandeController()),
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: isMobile?20: 60, vertical: 20),
                    child: CustomText(
                      text: categorieName.toString(),
                      fontSize: 20,
                      color: Colors.black,
                    )),
                Container(
                 
                   margin: EdgeInsets.symmetric(horizontal:isMobile?0: 40),
                  child: GridView.builder(
                    shrinkWrap: true,
                    //scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:isMobile ?0.5: 0.57,//0.68,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount:isMobile ? 3: 4,
                    ),
                    // primary: false,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: listProduits!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      double pourcentage = listProduits![index].price! *
                          100 /
                          listProduits![index].solde!;
                      return itemProduct(controller, index, pourcentage,isMobile);
                    },
                  ),
                ),
              ],
            ));
  }

  InkWell itemProduct(
      CommandeController controller, int index, double pourcentage,bool isMobile) {
    return InkWell(
      onTap: () {
        // controller.produit = listProduits![index];
        /* Get.to(DetailScreen(
                    idCategory: idCategory,
                    /* categorieName: categorieName,
                    listProduits: listProduits, */
                  ));*/
        Get.toNamed(
            "/DetailProduit?nomcategories=${categorieName}&idCategorie=${idCategory}&idProduit=${listProduits![index].idProduit}");
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  listProduits![index].images![0].toString(),
                  fit: BoxFit.cover,


                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(text: listProduits![index].name.toString()),
              CustomText(
                text: '${listProduits![index].price.toString()} DT',
                color: Colors.red,
              )
            ],
          ),
          if (listProduits![index].solde! > listProduits![index].price!)
            Positioned(
              top: 20,
              left: 10,
              child: Container(
                alignment: Alignment.center,
                width:isMobile?30: 50,
                height:isMobile?15: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  '${100 - pourcentage.round()} %',
                  style: TextStyle(
                    fontSize: isMobile?12:15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
