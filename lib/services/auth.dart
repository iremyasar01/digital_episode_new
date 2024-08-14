
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth{

  

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//final userCollection = FirebaseFirestore.instance.collection("Users");
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//user collectionıma verilerimi kaydedicem.

//firebaseden user dön.
  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authChanges => firebaseAuth.authStateChanges();
  //bir değişikliği olduğu zaman stream sayesinde haberim olacak.
  //authStateChanges kullanıcımız çıkış yaptı mı içeride mi falan.
    // Firebase veya başka bir backend üzerinde e-posta kontrolü yapıyoruz.


  Future<void> singUp ({
    required String username,
    required String email,
   required String password,
   required String name, 
   required String surname, 
   required String phoneNumber}) async {
  

      try{

       /*
      if(userCredential.user!=null){
  
        createUser(email: email, username: username, password: password, name: name,surname: surname, phoneNumber: phoneNumber);

      }
    */
    
  
      }
      on FirebaseAuthException catch(e){
     
        Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
      }
  
  

  }

//register
Future<void> createUser ({
  required String email,
  required String username,
  required String name,
  required String surname,
  required String phoneNumber,
  required String password,
  
}) async {
  //await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
     UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
     User? user =userCredential.user;
   CollectionReference users = _firestore.collection("Users");
        

  users.doc(user!.uid).set({
    "email": email,
    "username": username,
    "name": name,
    "surname": surname,
    "phoneNumber": phoneNumber,
    "password": password,


  }
    
  );
}



//login 
Future<void> singIn (BuildContext context,{required String email, required String password, required String username})
async{  
  try{
  final UserCredential userCredential= await firebaseAuth.signInWithEmailAndPassword(email: email
  , password: password);
   if(userCredential.user!=null){
       

  }


  }
  on FirebaseAuthException catch(e){
  Fluttertoast.showToast(msg: e.message!);

  }

 
}

//sing out
Future<void> singOut() async{
  await firebaseAuth.signOut();
  
    
}
}
