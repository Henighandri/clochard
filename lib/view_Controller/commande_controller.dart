import 'package:clochard/Screen/Home_screen.dart';
import 'package:clochard/Screen/panier_screen.dart';
import 'package:clochard/database_service/home_sevice.dart';
import 'package:clochard/database_service/panier.service.dart';
import 'package:clochard/model/commande.dart';
import 'package:clochard/model/produit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CommandeController extends GetxController {


CommandeController()  {
  // getProduitFromBase(idCategory.toString(), idProduit.toString());
}
  /****** */
 /*   Produit? _produit;
   Produit? get produit=>_produit;

   set produit(Produit? p){
        _produit=p;
        update();
   } */

   /************* */
double total = 0;
   List<Commande> _listCommandes=[];
  List<Commande> get listCommandes=>_listCommandes;

   addCommande(Commande commande){
     _listCommandes.add(commande);
    // _colorIndex=-1;
   //  _tailleIndex=-1;
     update();
     getTotal();
   }
   
  void incrementquantity(int index) {
    if (_listCommandes[index].quantity <= 0) {
      _listCommandes[index].quantity = 1;
    }
    _listCommandes[index].quantity++;

    update();
    getTotal();
  }

  void decrementquantity(int index) {
    _listCommandes[index].quantity  --;
    if (_listCommandes[index].quantity <= 0) {
      _listCommandes[index].quantity = 1;
    }
    update();
    getTotal();
  }

  void delete(int index) {
    _listCommandes.removeAt(index);
    getTotal();
    update();
  }

  void getTotal() {
    double _total = 0;
    for (var i = 0; i < _listCommandes.length; i++) {
      _total = _total + _listCommandes[i].produit!.price!*_listCommandes[i].quantity;
    }
    total = _total;
    update();
  }

 Future<void> setDataInFireBase()async{
   await PanierService().setCommandeInDataBase(FirebaseAuth.instance.currentUser!.uid, _listCommandes);
    _listCommandes.clear();
    getTotal();
    update();
   // Get.to(HomeScreen());
  }
  bool produitIsExist(Produit produit){
    for(int i=0;i<_listCommandes.length;i++){
      if(_listCommandes[i].produit!.idProduit==produit.idProduit){
        return true;
      }

    }
    return false;
  }

 
  


}
