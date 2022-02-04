import 'package:clochard/helper/extension.dart';
import 'package:clochard/model/commande.dart';
import 'package:clochard/model/produit.dart';
import 'package:flutter/material.dart';

class CartItemMobile extends StatelessWidget {
  const CartItemMobile({ Key? key, required this.commande }) : super(key: key);
  final Commande commande; 
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFDCDCDC).withOpacity(0.3),
              ),
              height: 80,
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network('${commande.produit!.images![0]}')),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${commande.produit!.name}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text(
                              "${commande.produit!.price} dt",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red),
                            ),
                             SizedBox(
                              width: 10,
                            ),
                              Text(
                              "Couleur : ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                             Container(width: 20,height: 20,color: HexColor.fromHex(commande.color.toString())),
                          ],
                        ),
                        SizedBox(height: 5,),
                      //  if(commande.size!=null)
                        Row(
                          children: [
                            Text(
                              "Taille : ${commande.size}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Quantité : ${commande.quantity}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        )
                       
                      ],
                    ),
                  )
                ],
              ),
            );
  }
}