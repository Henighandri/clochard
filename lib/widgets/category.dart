import 'package:clochard/Screen/detail_screen.dart';
import 'package:clochard/model/produit.dart';
import 'package:clochard/view_Controller/commande_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';


import '../responsive.dart';
import 'custom_text.dart';

class Category extends StatelessWidget {
  Category(
      {Key? key,
      required this.categorieName,
      required this.listProduits,
      required this.idCategory,
      this.showFlesh = true})
      : super(key: key);

  final String categorieName;
  final List<Produit>? listProduits;
  final String idCategory;
  final bool showFlesh;

  final controllerScroll = ScrollController();

  int position = 0;

  void scrollTo(int pos, BuildContext context) {
    final width =
        controllerScroll.position.maxScrollExtent + context.size!.width;
    final value = pos * width;

    controllerScroll.animateTo(value,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Responsive.isTablet(context);
    final bool isMobile = Responsive.isMobile(context);
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: isMobile ? 0 : 100, vertical: 20),
            child: CustomText(
              text: categorieName.toString(),
              fontSize: 20,
              color: Colors.black,
            )),
        Container(
          height: isMobile
              ? 235
              : isTablet
                  ? 280
                  : 400,
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showFlesh)
                Container(
                  width: 30,
                  height: 100,
                  margin: EdgeInsets.only(right: 20, top: isTablet ? 60 : 110),
                  color: Color(0xFF989898),
                  child: InkWell(
                      onTap: () {
                        position = position - 1 < 0 ? position : position - 1;
                        scrollTo(position, context);
                      },
                      child: Image.asset("assets/icons/flech_left.png")),
                ),
              Expanded(
                child: ListView.separated(
                  controller: controllerScroll,
                  scrollDirection: Axis.horizontal,
                  itemCount: listProduits!.length,
                  itemBuilder: (context, index) {
                    double pourcentage = listProduits![index].price! *
                        100 /
                        listProduits![index].solde!;
                    return InkWell(
                      onTap: () {
                        //  controller.produit = listProduits![index];
                        /*    Get.to(DetailScreen(
                            idCategory: idCategory,
                            categorieName: categorieName,
                            listProduits: listProduits,
                          ));  */
                        Get.toNamed(
                            "/DetailProduit?nomcategories=${categorieName}&idCategorie=${idCategory}&idProduit=${listProduits![index].idProduit}");
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: isMobile
                                      ? 130
                                      : isTablet
                                          ? 150
                                          : 200,
                                  
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  fit: BoxFit.cover,
                                  width: isMobile
                                      ? 130
                                      : isTablet
                                          ? 150
                                          : 200,
                                  height: isMobile
                                      ? 180
                                      : isTablet
                                          ? 220
                                          : 320,
                                 image: listProduits![index].images![0].toString(),
                                ),
                              /*   Image.network(
                                  listProduits![index].images![0].toString(),
                                  fit: BoxFit.cover,
                                  width: isMobile
                                      ? 130
                                      : isTablet
                                          ? 150
                                          : 200,
                                  height: isMobile
                                      ? 180
                                      : isTablet
                                          ? 220
                                          : 320,
                                 
                                ), */
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                    text: listProduits![index].name.toString()),
                                CustomText(
                                  text:
                                      '${listProduits![index].price.toString()} DT',
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                          if (listProduits![index].solde! >
                              listProduits![index].price!)
                            Positioned(
                              top: 20,
                              left: 10,
                              child: Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Text(
                                  '${100 - pourcentage.round()} %',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 20,
                  ),
                ),
              ),
              if (showFlesh)
                Container(
                  margin: EdgeInsets.only(left: 20, top: isTablet ? 60 : 110),
                  width: 30,
                  height: 100,
                  color: Color(0xFF989898),
                  child: InkWell(
                      onTap: () {
                        position = position + 1 >= listProduits!.length / 3
                            ? position
                            : position + 1;
                        scrollTo(position, context);
                      },
                      child: Image.asset("assets/icons/flech_right.png")),
                )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
