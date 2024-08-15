
//import 'package:digital_episode_new/services/firebase_services.dart';
import 'package:digital_episode_new/components/action.dart';
import 'package:flutter/material.dart';
//import 'package:digital_episode_new/utils/colors.dart';
class MyProfile extends StatelessWidget {
   final String email, username, name, surname, phoneNumber, password, passwordAgain;
   
  const MyProfile({super.key,

  required this.email,
  required this.username,
  required this.name, required this.surname,
  required this.phoneNumber,
  required this.password, required this.passwordAgain});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed("/action", arguments: ( ActionType.update, email,username,name, surname, phoneNumber, password,passwordAgain )),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                email,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 3),
            Text(
                username,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 3),
               Text(
                name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 3),
               Text(
                surname,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 3),
               Text(
                phoneNumber,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 3),
               Text(
                password,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 3),
               Text(
                passwordAgain,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              
            ],
          ),
        ),
      ),
        
              
      
       
      );
  }
}
