
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_episode_new/components/my_users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:get/state_manager.dart';

class Auth {
//extends GetxController{



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
Stream<MyUsersModel> getMyUsersAsStream() {
  String uid = currentUser!.uid;
  return FirebaseFirestore.instance.collection("Users").doc(uid)
    .snapshots()
    .map((snapshot) => MyUsersModel.fromJson(snapshot.data()!));
}

  Future<void> updateUser({
    //required String email,
    //required String username,
    required String name,
    required String surname,
    required String phoneNumber,
    required String password,
  }) async {
    

   // await _firestore.collection("Users").doc(uid).delete();
     String uid = currentUser!.uid;
     //await removeItem(uid: uid);
  

    await _firestore.collection("Users").doc(uid).update({
      //"email": email,
      //"username": username,
      "name": name,
      "surname": surname,
      "phoneNumber": phoneNumber,
      "password": password,
    });
     // var updatedUserDoc = await _firestore.collection("Users").doc(uid).get();
  }


  Future<void> removeItem ({ required String uid})async {
  
 await _firestore.collection("Users").doc(uid).delete();
  }
   Future<void> addFavorite({
    required String seriesId,
    required String title,
    required String posterUrl,
  }) async {
    try {
      await _firestore.collection('Users').doc(currentUser!.uid).collection('favorites').doc(seriesId).set({
        'seriesId': seriesId,
        'title': title,
        'posterUrl': posterUrl,
        'addedAt': Timestamp.now(),
      });
      Fluttertoast.showToast(msg: "Series added to favorites!");
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to add series: $e");
    }
  }

  Future<void> removeFavorite(String seriesId) async {
    try {
      await _firestore.collection('Users').doc(currentUser!.uid).collection('favorites').doc(seriesId).delete();
      Fluttertoast.showToast(msg: "Series removed from favorites!");
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to remove series: $e");
    }
  }

  Future<bool> isFavorite(String seriesId) async {
    User? user = currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _firestore.collection('Users').doc(user.uid).collection('favorites').doc(seriesId).get();
      return doc.exists;
    }
    return false;
  }
    // Kullanıcının tüm favorilerini alma
  Stream<List<Map<String, dynamic>>> getFavorites() {
    String uid = currentUser!.uid;
    return _firestore
        .collection('Users')
        .doc(uid)
        .collection('favorites')
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => doc.data()).toList());
  }
  // Check if the movie is a favorite
  Future<bool> isFavoriteMovie(String movieId) async {
     User? user = currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _firestore
          .collection('Users')
          .doc(user.uid)
          .collection('fav_movies')
          .doc(movieId)
          .get();
      return doc.exists;
    }
    return false;
  }

  // Add movie to favorites
  Future<void> addFavoriteMovie({required String movieId, required String title, required String posterUrl}) async {
    User? user = currentUser;
    if (user != null) {
      await _firestore.collection('Users').doc(user.uid).collection('fav_movies').doc(movieId).set({
        'title': title,
        'posterUrl': posterUrl,
        'addedAt': Timestamp.now(),
      });
    }
  }

  // Remove movie from favorites
  Future<void> removeFavoriteMovie(String movieId) async {
     User? user = currentUser;
    if (user != null) {
      await _firestore.collection('Users').doc(user.uid).collection('fav_movies').doc(movieId).delete();
    }
  }
      // Kullanıcının film favorilerini alma
  Stream<List<Map<String, dynamic>>> getMoviesFavorites() {
    String uid = currentUser!.uid;
    return _firestore
        .collection('Users')
        .doc(uid)
        .collection('fav_movies')
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => doc.data()).toList());
  }
  // Add a series to the watchlist
  Future<void> addToWatchlist({
    required String seriesId,
    required String title,
    required String posterUrl,
  }) async {
   User? user = currentUser;
    if (user != null) {
      final watchlistRef = _firestore
          .collection('Users')
          .doc(user.uid)
          .collection('watchlist')
          .doc(seriesId);

      await watchlistRef.set({
        'title': title,
        'posterUrl': posterUrl,
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // Remove a series from the watchlist
  Future<void> removeFromWatchlist(String seriesId) async {
    User? user = currentUser;
    if (user != null) {
      final watchlistRef = _firestore
          .collection('Users')
          .doc(user.uid)
          .collection('watchlist')
          .doc(seriesId);

      await watchlistRef.delete();
    }
  }

  // Check if a series is in the watchlist
  Future<bool> isInWatchlist(String seriesId) async {
    User? user = currentUser;
    if (user != null) {
      final watchlistRef = _firestore
          .collection('Users')
          .doc(user.uid)
          .collection('watchlist')
          .doc(seriesId);

      final docSnapshot = await watchlistRef.get();
      return docSnapshot.exists;
    }
    return false;
  }
   Stream<List<Map<String, dynamic>>> getSeriesWatchList() {
    String uid = currentUser!.uid;
    return _firestore
        .collection('Users')
        .doc(uid)
        .collection('watchlist')
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => doc.data()).toList());
  }
  // Add a series to the watchlist
  Future<void> addToMoviesWatchlist({
    required String moviesId,
    required String title,
    required String posterUrl,
  }) async {
   User? user = currentUser;
    if (user != null) {
      final watchlistRef = _firestore
          .collection('Users')
          .doc(user.uid)
          .collection('Moviewatchlist')
          .doc(moviesId);

      await watchlistRef.set({
        'title': title,
        'posterUrl': posterUrl,
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> removeFromMovieWatchlist(String moviesId) async {
    User? user = currentUser;
    if (user != null) {
      final watchlistRef = _firestore
          .collection('Users')
          .doc(user.uid)
          .collection('Moviewatchlist')
          .doc(moviesId);

      await watchlistRef.delete();
    }
  }

  // Check if a series is in the watchlist
  Future<bool> isInMovieWatchlist(String moviesId) async {
    User? user = currentUser;
    if (user != null) {
      final watchlistRef = _firestore
          .collection('Users')
          .doc(user.uid)
          .collection('Moviewatchlist')
          .doc(moviesId);

      final docSnapshot = await watchlistRef.get();
      return docSnapshot.exists;
    }
    return false;
  }
   Stream<List<Map<String, dynamic>>> getMoviesWatchList() {
    String uid = currentUser!.uid;
    return _firestore
        .collection('Users')
        .doc(uid)
        .collection('Moviewatchlist')
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => doc.data()).toList());
  }
}
  /*
   Future<void> addFavoriteMovie({
    required String movieId,
    required String title,
    required String posterUrl,
  }) async {
    try {
      await _firestore.collection('Users').doc(currentUser!.uid)
          .collection('fav_movies').doc(movieId).set({
        'movieId': movieId,
        'title': title,
        'posterUrl': posterUrl,
      });
      Fluttertoast.showToast(msg: "Movie added to favorites!");
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to add movie: $e");
    }
  }
  Future<void> addFavoriteSeries({
    required String seriesId,
    required String title,
    required String posterUrl,
  }) async {
    try {
      await _firestore.collection('Users').doc(currentUser!.uid)
          .collection('fav_series').doc(seriesId).set({
        'seriesId': seriesId,
        'title': title,
        'posterUrl': posterUrl,
      });
      Fluttertoast.showToast(msg: "Series added to favorites!");
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to add series: $e");
    }
  }
}


//var myUser= MyUsersModel().obs;
//MyUsersModel myUser= MyUsersModel();
  Stream<MyUsersModel> getMyUsersAsStream() {
    String uid =currentUser!.uid;
   final mycurrentuser =  _firestore.collection("Users").doc(uid)
    .snapshots().
    map((event)=>
      //biz sadece event.data ile json'a ulaşıyoruz.
      //onu usersmodel türüne dönüştürmemiz lazım.
         MyUsersModel.fromJson(event.data()!));
    
    return mycurrentuser;

  }

  */

