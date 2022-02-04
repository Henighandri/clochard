import 'dart:convert';

import 'package:flutter/foundation.dart';



class Produit {
 List<dynamic>? images;
 List<dynamic>? sizes;
 List<dynamic>? colors;
 String? idProduit;
  String? name;
  double? price;
double? solde;
  Produit({
    this.images,
    this.sizes,
    this.colors,
    this.idProduit,
    this.name,
    this.price,
    this.solde
  });
 
  




  Produit copyWith({
    List<dynamic>? images,
    List<dynamic>? sizes,
    List<dynamic>? colors,
    String? idProduit,
    String? name,
    double? price,
    double? solde,
  }) {
    return Produit(
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      idProduit: idProduit ?? this.idProduit,
      name: name ?? this.name,
      price: price ?? this.price,
      solde: solde ?? this.solde,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'sizes': sizes,
      'colors': colors,
      'idProduit': idProduit,
      'name': name,
      'price': price,
      'solde': solde,
    };
  }

  factory Produit.fromMap(Map<String, dynamic> map) {
    return Produit(
      images: List<dynamic>.from(map['images']),
      sizes: List<dynamic>.from(map['sizes']),
      colors: List<dynamic>.from(map['colors']),
      idProduit: map['idProduit'],
      name: map['name'],
      price: map['price'],
      solde: map['solde'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Produit.fromJson(String source) => Produit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Produit(images: $images, sizes: $sizes, colors: $colors, idProduit: $idProduit, name: $name, price: $price, solde: $solde)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Produit &&
      listEquals(other.images, images) &&
      listEquals(other.sizes, sizes) &&
      listEquals(other.colors, colors) &&
      other.idProduit == idProduit &&
      other.name == name &&
      other.price == price &&
      other.solde == solde;
  }

  @override
  int get hashCode {
    return images.hashCode ^
      sizes.hashCode ^
      colors.hashCode ^
      idProduit.hashCode ^
      name.hashCode ^
      price.hashCode ^
      solde.hashCode;
  }
}
