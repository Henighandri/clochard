

import 'package:clochard/model/commande.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PanierService{
     CollectionReference _commandesCollectionRef=
     FirebaseFirestore.instance.collection("Commandes");


Future<void> setCommandeInDataBase(String idUser,List<Commande> list) async {
  DocumentReference docRef=_commandesCollectionRef.doc(idUser).collection("cart").doc();
_commandesCollectionRef.doc(idUser).set({"aa":""});
  CollectionReference _ref=docRef
  .collection("commande");
   final DateTime now = DateTime.now();
/*    final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now); */
  docRef.set({"date":now,
  "confirmer":false
  });
  
  for(int i=0;i<list.length;i++){
  await  _ref.doc(list[i].produit!.idProduit).set(
      {
        "idProduit":list[i].produit!.idProduit,
          "price":list[i].produit!.price,
          "quantity":list[i].quantity,
          "size":list[i].size,
          "color":list[i].color,
          "idCategory":list[i].idCategory,
      }
    );
  }
}

}