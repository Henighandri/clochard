import 'package:clochard/Screen/mobile/customAppBarMobile.dart';
import 'package:clochard/helper/extension.dart';
import 'package:clochard/model/commande.dart';
import 'package:clochard/model/produit.dart';
import 'package:clochard/view_Controller/commande_controller.dart';
import 'package:clochard/view_Controller/detailController.dart';
import 'package:clochard/widgets/custom_btn.dart';
import 'package:clochard/widgets/custom_text.dart';
import 'package:clochard/widgets/image_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreenMobile extends StatefulWidget {
  const DetailScreenMobile({ Key? key }) : super(key: key);

  @override
  _DetailScreenMobileState createState() => _DetailScreenMobileState();
}

class _DetailScreenMobileState extends State<DetailScreenMobile> {
   @override
  void initState() {
    Get.create<DetailController>(() => DetailController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMobile(),
      body:  GetBuilder<DetailController>(
        builder: (controller) =>controller.isLoading
        ?Center(child: CircularProgressIndicator(),)
        : SingleChildScrollView(
          child: Column(
            children: [
               ImageSwipe(
                        imageList: controller.produit!.images!,
                        pressDrawer: (){},
                        imageProduit: true,
                      ),
                      
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                           controller.produit!.name.toString(),
                           style: TextStyle(
                             fontWeight: FontWeight.w600,
                             fontSize: 24,
                           ),
                         ),
                         SizedBox(height: 10),
                                if (controller.produit!.solde! > controller.produit!.price!)
                               Container(
                                 alignment: Alignment.center,
                                 width: 80,
                                 height: 30,
                                 decoration: BoxDecoration(
                                     color: Colors.red,
                                     borderRadius: BorderRadius.circular(40)),
                                 child: Text(
                                   'SOLDE',
                                   style: TextStyle(
                                     color: Colors.white,
                                     fontWeight: FontWeight.w600,
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         SizedBox(height: 10),
                         
                         Row(
                           children: [
                             Text(
                               "${controller.produit!.price.toString()} dt",
                               style: TextStyle(
                                 color: Colors.red,
                                 fontWeight: FontWeight.w600,
                                 fontSize: 24,
                               ),
                             ),
                             SizedBox(
                               width: 30,
                             ),
                             if (controller.produit!.solde! > controller.produit!.price!)
                               Stack(
                                 alignment: Alignment.center,
                                 children: [
                                   Text(
                                     "${controller.produit!.solde.toString()} dt",
                                     style: TextStyle(
                                       color: Colors.grey,
                                       fontWeight: FontWeight.w600,
                                       fontSize: 24,
                                     ),
                                   ),
                                   Container(
                                     width: 80,
                                     child: Divider(
                                       thickness: 2,
                                       color: Colors.red,
                                     ),
                                   )
                                 ],
                               )
                           ],
                         ),
                         SizedBox(height: 10),
                         colorMethod(context, controller),
                         SizedBox(height: 10),
                         tailleMethod(context, controller),
                         SizedBox(
                           height: 10,
                         ),
                         Text(
                           'Quantite : ',
                           style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                        
                           Container(
                             height: 40,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 QuantityWidget(
                                   controller: controller,
                                 ),
                                 SizedBox(
                                   width: 10,
                                 ),
                                  ButtonPanier(
                                     idCategory:Get.parameters["idCategorie"].toString(),
                                     colorIndex: controller.colorIndex,
                                     tailleIndex: controller.tailleIndex,
                                     quantity: controller.quantity!,
                                     produit: controller.produit!) 
                               ],
                             ),
                           ),
                        
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Container tailleMethod(BuildContext context, DetailController controller) {
    return Container(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Taille : ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
         // padding: EdgeInsets.only(top: 10),
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.produit!.sizes!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.tailleIndex = index;
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: controller.tailleIndex == index
                                  ? Colors.grey.withOpacity(.5)
                                  : null,
                              border: Border.all(color: Colors.grey)),
                          child: Text(
                            controller.produit!.sizes![index],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
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

  Container colorMethod(BuildContext context, DetailController controller) {
    return Container(
      width: 300,
      // height: 150,

      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 5,
        ),
        Text(
          'Couleurs :',
          style: TextStyle(fontWeight: FontWeight.w600),
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
                    itemCount: controller.produit!.colors!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.colorIndex = index;
                        },
                        child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.only(right: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller.colorIndex == index
                                        ? Colors.red
                                        : Colors.grey,
                                    width: 1)),
                            child: Container(
                                margin: EdgeInsets.all(8),
                                //color: produit!.colors![index],
                                color: HexColor.fromHex(
                                    controller.produit!.colors![index]))),
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

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({Key? key, required this.controller}) : super(key: key);

  final DetailController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              controller.decrement();
            },
            child: Container(
              height: 40,
              padding: EdgeInsets.only(bottom: 20),
              child: Icon(
                Icons.minimize,
                color: Colors.black,
              ),
            ),
          ),
          Text(controller.quantity.toString(),
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
          InkWell(
            onTap: () {
              controller.increment();
            },
            child: Container(
              height: 40,
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonPanier extends StatefulWidget {
  const ButtonPanier({
    Key? key,
    required this.idCategory,
    required this.colorIndex,
    required this.tailleIndex,
    required this.quantity,
    required this.produit,
  }) : super(key: key);

  final String idCategory;
  final int colorIndex;
  final int tailleIndex;
  final int quantity;
  final Produit produit;

  @override
  _ButtonPanierState createState() => _ButtonPanierState();
}

class _ButtonPanierState extends State<ButtonPanier> {
  Future<void> _alertDialogBuilder() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: 450,
              height: 200,
              color: Color(0xFF0abf3a),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Produit ajouté au panier avec succès",
                    color: Colors.white,
                    fontSize: 16,
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBtn(
                        width: 100,
                        height: 40,
                        text: "Continue",
                        bgColor: Colors.black,
                        txtColor: Colors.white,
                        onPressed: () {
                        // Get.toNamed("/Home");
                         Get.offAndToNamed("/Home");
                        },
                      ),
                      CustomBtn(
                        width: 100,
                        height: 40,
                        text: "Voir Panier",
                        bgColor: Colors.black,
                        txtColor: Colors.white,
                        onPressed: () {
                         Get.offAndToNamed("/Panier");
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommandeController>(
      init: Get.put(CommandeController()),
      builder: (controller) => InkWell(
        onTap: () {
          if (widget.colorIndex != -1 && widget.tailleIndex != -1) {
            if (!controller.produitIsExist(widget.produit)) {
              controller.addCommande(Commande(
                  idCategory: widget.idCategory,
                  produit: widget.produit,
                  color: widget.produit.colors![widget.colorIndex],
                  size: widget.produit.sizes![widget.tailleIndex],
                  quantity: widget.quantity));

              _alertDialogBuilder();
            } else {
              Get.snackbar("erreur", "ce produit existe déja dans le panier ",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  maxWidth: MediaQuery.of(context).size.width * .7,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10));
            }
          } else {
            Get.snackbar(
                "erreur", "veuillez selectionner le taille et le coleur",
                backgroundColor: Colors.red,
                colorText: Colors.white,
                maxWidth: MediaQuery.of(context).size.width * .7,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10));
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              // controller.addItem(icon, nom, couleur, taille, quantite, prix),
              "Ajouter au Panier",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }
}