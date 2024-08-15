/*
//posts
class UsersModels{
  final List<MyUsersModel> usersModels;
  UsersModels({required this.usersModels});

  factory UsersModels.fromJson(Map<String, dynamic>? json){
    List<MyUsersModel> usersModels = [];
if(json !=null){
  for(var i in json["userModels"]){
    usersModels.add(MyUsersModel.fromJson(i));
  }
}//dışarıdan aldığım json null değilse listemi dön.
  return UsersModels(usersModels: usersModels);
//dışarıdan aldığım json nullsa boş liste dön.
  }

}
*/

//import 'package:flutter/foundation.dart';

class MyUsersModel{
 final String?   email, username, name, surname,phoneNumber, password, passwordAgain;
MyUsersModel({ required this.email, required  this.username, required  this.name, required this.surname,required  this.phoneNumber,required  this.password,required  this.passwordAgain} );
 factory MyUsersModel.fromJson(Map<String, dynamic> json){
 return MyUsersModel(
    email: json["email"],
    username:  json["username"],
    name: json["name"], 
    surname: json["surname"],
    phoneNumber: json["phoneNumber"],
    password: json["password"],
    passwordAgain:json["passwordAgain"],);
  }
}
