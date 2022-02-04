import 'package:clochard/responsive.dart';
import 'package:clochard/widgets/custom_filtre.dart';
import 'package:clochard/widgets/custom_footer.dart';

import 'package:clochard/widgets/custom_text.dart';
import 'package:clochard/widgets/image_swipe.dart';
import 'package:clochard/widgets/new_collection.dart';
import 'package:clochard/widgets/products_widget.dart';
import 'package:clochard/widgets/raison.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
GlobalKey<ScaffoldState> _scafoldKey=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
  final bool isTablet = Responsive.isTablet(context);
    return Scaffold(
     key: _scafoldKey,
      drawer: CustomFiltre(),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageSwipe(
                imageList: [
                  "assets/images/1.png",
                  "assets/images/2.png",
                  "assets/images/3.png",
                ],
                pressDrawer: (){
                  _scafoldKey.currentState!.openDrawer();
                },
              ),
             
              SizedBox(
                height: 60,
              ),
              NewCollection(),
              SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(Responsive.isDesktop(context))
                  Expanded(
                    flex: 1,
                    child: Container(
                        height:800 ,
                       // width:350,
                        margin: EdgeInsets.only(left: 30),
                        color: Color(0xFFF5F5F5),
                        child: CustomFiltre()),
                  ),
                  Expanded(
                    flex: 3,
                     // width: MediaQuery.of(context).size.width * .65,
                      child: ProductsWidget())
                ],
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomText(
                  text: "Pourquoi choisir Clochard ?",
                  fontSize: 20,
                  color: Colors.black,
                  alignment: Alignment.center,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Raison(
                        image: "assets/images/icon1.png",
                        title: 'Paiements facile',
                        description: !isTablet
                            ?'Tous les paiements sont traités instantanément\n via un protocole de paiement sécurisé.'
                            :'Tous les paiements sont traités\n instantanément via un protocole\n de paiement sécurisé.'
                            ),
                    Raison(
                        image: "assets/images/icon.png",
                        title: 'Livraison Rapide',
                        description: 'Livraison rapide \nentre 1 - 2 jours'),
                    Raison(
                        image: "assets/images/icon2.png",
                        title: 'Meilleure qualité',
                        description:!isTablet
                            ?'Chacun de nos produits a \nété conçu avec les meilleurs matériaux.'
                            :'Chacun de nos produits a \nété conçu avec les meilleurs\n matériaux.'
                            ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CustemFooter()
            ],
          ),
        ),
      ),
    );
  }
}
