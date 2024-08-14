
import 'package:digital_episode_new/screens/home_screen.dart';
import 'package:digital_episode_new/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

 GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController usernameController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController passwordAgainController;

    String? username, email, password, passwordAgain, name, surname, phoneNumber;
    
    void showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
        );
      },
    );
    
  }
  
  
  Future<void> createUserr() async{
    try{
    await Auth().createUser(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
      name: nameController.text,
      surname: surnameController.text,
      phoneNumber: phoneNumberController.text,
  
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (Route<dynamic> route) => false,
    );
    } on FirebaseAuthException catch (e){
      showError(e.code);
//benim authta oluşturuğum fonka git değerlerini al eğer bi hata olursa errormessage at.
//aynısını sing in içinde.
    }
    
   }
   
   @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    emailController =TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    passwordAgainController = TextEditingController();

  }
  @override
  void dispose(){
    super.dispose();
    usernameController.dispose();
    nameController.dispose();
    surnameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 231, 185, 239),
        body:
        SingleChildScrollView(
          child: Column(
            children:[
               const SizedBox(height: 90),
               Form(
              key: formKey,
            child: Container(
            margin: const  EdgeInsets.all(20),
                    //child: Padding(
                      //padding: const EdgeInsets.only(top:170),
            child: Column(
              children: [
                TextFormField(
              controller: emailController,
              decoration:  InputDecoration(
                labelText: "email",
                hintText: "please enter the email",
                 prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
              ),
              ),
            ), const SizedBox(height: 15),
            TextFormField(
              controller: usernameController,
              decoration:  InputDecoration(
                labelText: "username",
                hintText: "please enter the username",
                 prefixIcon: const Icon(Icons.account_box_outlined),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
              ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
             controller: nameController,
              decoration:  InputDecoration(
                labelText: "Name",
                hintText: "please enter the name",
                 prefixIcon: const Icon(Icons.account_box_outlined),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
              ),
              ),
            ),
              const SizedBox(height: 15),
              TextFormField(
             controller: surnameController,
              decoration:  InputDecoration(
                labelText: "Surname",
                hintText: "please enter the surname",
                 prefixIcon: const Icon(Icons.account_box_outlined),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
              ),
              ),
            ),
              const SizedBox(height: 15),
              TextFormField(
              controller: phoneNumberController,
              decoration:  InputDecoration(
                labelText: "phone number",
                hintText: "please enter the phone number",
                 prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
              ),
              ),
            ),
                const SizedBox(height: 15),
              TextFormField(
             controller: passwordController,
              decoration:  InputDecoration(
                labelText: "password",
                hintText: "please enter the password",
                 prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
              ),
              ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return "you have to enter the password!";
                  }
                  if (value.length < 7) {
                    return "it should be more longer!";
                  }
                  return null;
                },
                obscureText: true,
                onSaved: (newValue) {
                  password = newValue;
                }, 
            ),
                const SizedBox(height: 15),
              TextFormField(
             controller: passwordAgainController,
              decoration:  InputDecoration(
                labelText: "password again",
                hintText: "please enter the password again",
                 prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
              ),
              ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (newValue) {
                  if (newValue == null || newValue.isEmpty){
                    return "you have to enter the password!";
                  }
                  if (passwordController.text != passwordAgainController.text){
                    return "these are not match!";
                  }
                  return null;
                },
                obscureText: true,
                onSaved: (newValue) {
                  passwordAgain = newValue;
                }, 
            ),
  
            ],
            ),
            ),
               ),
         ElevatedButton(onPressed: (){
          createUserr();
           
         }, child: const  Text("save")),
                                             
        ],
          )

    ));
    
  }
}
