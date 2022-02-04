import 'dart:convert';

import 'package:clochard/model/produit.dart';

class Commande {
  Produit? produit;
  String? idCategory;
  String? color;
  String? prix;
  String? size;
  int quantity;
  String? date;
  
  Commande({
    this.produit,
    this.color,
    this.size,
    this.quantity=1,
    this.date,
    this.idCategory,
    this.prix,
  });
  

 
  }

 