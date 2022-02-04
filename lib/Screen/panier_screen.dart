import 'package:clochard/Screen/Home_screen.dart';
import 'package:clochard/helper/extension.dart';
import 'package:clochard/model/commande.dart';
import 'package:clochard/view_Controller/commande_controller.dart';
import 'package:clochard/widgets/custom_app_bar.dart';
import 'package:clochard/widgets/custom_btn.dart';
import 'package:clochard/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive.dart';

class PanierScreen extends StatefulWidget {
  const PanierScreen({ Key? key }) : super(key: key);

  @override
  _PanierScreenState createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
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
                  CustomText(text: "Votre commande a été envoyer",
                  color: Colors.white,fontSize: 20,alignment: Alignment.center,),
                  SizedBox(height: 40,),
                  CustomBtn(
                    width: 200,
                    height: 50,
                    text: "Accueil",
                    bgColor: Colors.black,
                    txtColor: Colors.white,
                    onPressed: (){
                     Get.toNamed("/Home");
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isTablet = Responsive.isTablet(context);
    return Scaffold(
      backgroundColor: Colors.white,
          body: GetBuilder<CommandeController>(
        init: CommandeController(),
        builder:(controller) => Center(
            child: Column(
              children: [
                CustomAppBar(isDetailProduit: true,pressDrawer: (){},),
                Expanded(
                                  child: Container(
                    width:isTablet?MediaQuery.of(context).size.width*.9: MediaQuery.of(context).size.width*.7,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    margin: EdgeInsets.only(bottom: 20),
                    color: Color(0xFFF5F5F5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Panier',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.w800),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.shopping_cart_outlined),
                               // tooltip: 'Panier',
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Theme(
                                  data: Theme.of(context)
                                      .copyWith(dividerColor: Colors.transparent),
                                  child: DataTable(

                                    dataRowHeight: MediaQuery.of(context).size.width *0.07,
                                    horizontalMargin: 20,
                                    columnSpacing: 20,
                                    columns: [
                                      DataColumn(
                                        label: Text("Produit",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey)),
                                      ),
                                      DataColumn(
                                        label: Text("Couleur",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey))),
                                      DataColumn(
                                        label: Text("Taille",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey)),
                                      ),
                                      DataColumn(
                                        label: Text("Quantité",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey)),
                                      ),
                                      DataColumn(
                                        label: Text("Prix",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey)),
                                      ),
                                      DataColumn(
                                        label: Text("    "),
                                      ),
                                    ],
                                    rows: List.generate(
                                      controller.listCommandes.length,
                                      (index) => recentFileDataRow(
                                          index, context,controller),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ), ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 60),
                          color: Color(0xFFF5F5F5),
                          //alignment: MainAxisAlignment.spaceBetween,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  Get.toNamed("/home");
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_back),
                                    SizedBox(width: 20),
                                    Text(
                                      ' continuer vos achats',
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 19, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 50),
                                  Text(
                                   controller.total.toString(),
                                    style: TextStyle(
                                        fontSize: 19, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 50),
                                  InkWell(
                                    onTap: () async {
                                      if(FirebaseAuth.instance.currentUser!=null){
                                      if(controller.listCommandes.length!=0){
                                         await controller.setDataInFireBase();
                                         _alertDialogBuilder();
                                      }else{
                                         Get.snackbar(
                                            "erreur", "panier est vide",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            maxWidth: MediaQuery.of(context).size.width * .3,
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10));
                                      }
                                      }else{
                                        Get.snackbar(
                                            "erreur", "veuillez connecter pour passer la commande",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            maxWidth: MediaQuery.of(context).size.width * .3,
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10));
                                      }
                                    
                                    },
                                    child: Container(
                                      color: Colors.black,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 10),
                                        child: Text(
                                          'Confirmer',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    ),
     
    );
  }

  DataRow recentFileDataRow(int index, BuildContext context,CommandeController controller) {
    Commande commande=controller.listCommandes[index];
    return DataRow(
      cells: [
        DataCell(
          Container(
            padding: EdgeInsets.all(2),
            child: Row(
              children: [
                Image.network(
                  commande.produit!.images![0],
                  height: 100,
                  width: 100,
                ),
                Text(commande.produit!.name.toString(),style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
           
              ],
            ),
          ),
        ),
        DataCell(
          Container(width: 30,height: 30,color: HexColor.fromHex(commande.color.toString())),
          ),
        DataCell(Text(commande.size!,style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
        DataCell(
          Container(
            width: MediaQuery.of(context).size.width*0.1,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: () {controller.decrementquantity(index);},
                    child: Icon(
                      Icons.minimize,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(controller.listCommandes[index].quantity.toString(),style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                InkWell(
                  onTap: () {
                  controller.incrementquantity(index);},
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(Text(commande.produit!.price.toString(),style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),)),
        DataCell(IconButton(
          icon: Image.asset('assets/icons/close.png'),
          iconSize: 6,
          onPressed: () {controller.delete(index);},
        )),
      ],
    );
  }
}
