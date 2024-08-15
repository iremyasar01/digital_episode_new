//import 'package:digital_episode_new/services/firebase_services.dart';
import 'package:digital_episode_new/widgets/custom_button.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
enum ActionType {  update }
//insert ve update'di ama ben sadece update yapıcam. kullanıcı yeni şeyler ekleyemez.
class Action extends StatelessWidget {
   Action({super.key});

    final usernameController = TextEditingController();
   final  nameController = TextEditingController();
   final  surnameController = TextEditingController();
   final emailController =TextEditingController();
   final phoneNumberController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordAgainController = TextEditingController();
/*
  Widget titleWidget(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
  */

    Widget inputWidget(
      {TextEditingController? controller,String? labelText, String? hintText}) {
        
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white38, width: 1.5));
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
         border: border, enabledBorder: border, focusedBorder: border),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding:const EdgeInsets.all(20),
        child:Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          inputWidget(controller: usernameController, labelText: "username", hintText: "username"),
           inputWidget(controller: nameController, labelText: "name", hintText: "name"),
            inputWidget(controller: surnameController, labelText: "surname", hintText: "surname"),
             inputWidget(controller: emailController, labelText: "email", hintText: "email"),
              inputWidget(controller: phoneNumberController, labelText: "phone number", hintText: "phone number"),
               inputWidget(controller: passwordController, labelText: "password", hintText: "password"),
               inputWidget(controller: passwordAgainController, labelText: "password again", hintText: "password again"),
              CustomButton(text: "update",
              onPressed: (){
              
              },)
          
          
        ],)),
      ),
    );
  }
}