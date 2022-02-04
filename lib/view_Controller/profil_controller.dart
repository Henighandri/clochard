import 'package:clochard/database_service/profile_service.dart';
import 'package:clochard/model/commande.dart';
import 'package:clochard/model/produit.dart';
import 'package:clochard/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfilController extends GetxController{
  List<Commande> _listCommande=[];
 List<Commande> get listCommande=>_listCommande;
addListCommande(Commande commande){
  _listCommande.add(commande);
  update();
}
clearListHistorique(){
  _listCommande.clear();
  update();
}

ProfilController(){
  getInformationUser();
}

  bool _registerFromLoading = false;
  String? _email;
  
  String? _nom, _adresse, _codePostal, _prenom, _region, _tel;
 bool _historiqueSelected = false;
  
 
  List<String> _errorsProfile = [];
  

  bool get historiqueSelected => _historiqueSelected;

  set historiqueSelected(bool value) {
    _historiqueSelected = value;
    update();
  }

  String? get nom => _nom;
  set nom(String? value) {
    _nom = value;
  }

  String? get adresse => _adresse;
  set adresse(String? value) {
    _adresse = value;
  }

  String? get codePostal => _codePostal;
  set codePostal(String? value) {
    _codePostal = value;
  }

  String? get prenom => _prenom;
  set prenom(String? value) {
    _prenom = value;
  }

  String? get region => _region;
  set region(String? value) {
    _region = value;
  }

  String? get tel => _tel;
  set tel(String? value) {
    _tel = value;
  }

  List<String> get errorsProfile => _errorsProfile;

  String get email => _email!;
 

  set email(String email) {
    _email = email;
  }

  

  addError( String error) {
    _errorsProfile.add(error);
    update();
  }

  removeError( String error) {
    _errorsProfile.remove(error);
    update();
  }

  clearError() {
    _errorsProfile.clear();
    update();
  }

  bool get registerFormLoading => _registerFromLoading;

  set registerFormLoading(bool value) {
    _registerFromLoading = value;
    update();
  }

 Future<void> getInformationUser() async {
registerFormLoading=true;
    var infoUser=await ProfileService().getUser(FirebaseAuth.instance.currentUser!.uid);
    
 
     _email= infoUser["email"];
      
      _nom= infoUser["nom"];
      _adresse= infoUser["adresse"];
      _codePostal= infoUser["codePostal"];
      _prenom= infoUser["prenom"];
      _region= infoUser["region"];
       _tel= infoUser["tel"];
   
registerFormLoading=false;
  }


changeUserInformation() async {
   
    
    UserModel user = UserModel(
        email: email,
       
        region: _region,
        prenom: _prenom,
        tel: _tel,
        codePostal: _codePostal,
        adresse: _adresse,
        nom: _nom);
await ProfileService().changeUserInfo(user,FirebaseAuth.instance.currentUser!.uid );
      //  getInformationUser();
}


   Future<void> getHistorigue() async {
      clearListHistorique();
       String date;
     await ProfileService().getCommande(FirebaseAuth.instance.currentUser!.uid)
     
     .then((value) async{
          for(int j=0;j<value.length;j++)  {
             final DateFormat formatter = DateFormat('dd-MM-yyyy /HH:mm ');
               Timestamp timestamp=value[j]["date"];
                 date = formatter.format(timestamp.toDate()); 
                
             await ProfileService().getCommandeDetail(FirebaseAuth.instance.currentUser!.uid, value[j].id)
              .then((commandeList) async {
                for(int i=0;i<commandeList.length;i++)  {
                  //print(element["idProduit"]);
              Produit produit=  await ProfileService().getPrduit(commandeList[i]["idProduit"],commandeList[i]["idCategory"]);
        
              addListCommande(Commande(
                color:commandeList[i]["color"] ,
                prix: commandeList[i]["price"].toString(),
                idCategory:commandeList[i]["idCategory"] ,
                size: commandeList[i]["size"],
                quantity: commandeList[i]["quantity"],
                produit: produit,
                date: date,
              ));
                
                
                }
              });
          }
     });
     
     
   }
   List<Produit> _listProduit=[];
   List<Produit> get listProduit=>_listProduit;
    getAllProduitFromCommande(){
     _listCommande.forEach((element) {
       _listProduit.add(element.produit!);
     });
     update();
   }

}