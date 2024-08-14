import 'package:digital_episode_new/screens/home_screen.dart';
import 'package:digital_episode_new/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordAgainController;

   bool isLogin = true;
   String? username, email, password, passwordAgain;
   

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
  

  
   

   void singIn() async{
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, 
    password: passwordController.text);
      Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (Route<dynamic> route) => false,
    );
    } on FirebaseAuthException catch (e){
  
     showError(e.code);
  
   
    }
   }

  //final GlobalKey<FormState> formKey = GlobalKey<FormState>();
   @override
  void initState() {
    super.initState();
     usernameController = TextEditingController();
    emailController =TextEditingController();
    passwordController = TextEditingController();
    passwordAgainController = TextEditingController();

  }
  @override
  void dispose(){
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
  } 

@override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 185, 239),
        body:
        SingleChildScrollView(
          child: Column(
            children:[
               const SizedBox(height: 90),
            
               //Padding(
              //padding :const EdgeInsets.only(top: 50),
          
                
                   /* child:*/ Container( 
                    height: MediaQuery.of(context).size.height/4,
                     width: double.infinity,
                        decoration: const BoxDecoration(
                        image: DecorationImage(
                          alignment:Alignment.topCenter, 
                          image: AssetImage("assets/splashScreen.png"),
                       ),),
                                
                        ),
                 // ),
                       
              Form(
             // key: formKey,
            child: Container(
            margin: const  EdgeInsets.all(20),
                    //child: Padding(
                      //padding: const EdgeInsets.only(top:170),
            child: Column(
              children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "username",
                hintText: "please enter the username",
                 prefixIcon: const Icon(Icons.girl_outlined),
                     border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
              ),
              ),
               ),
                 const SizedBox(height: 15),
                 TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "email",
                hintText: "please enter the email",
                prefixIcon: const Icon(Icons.email_outlined),
                     border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
              ),
              ),
              validator: (value) {
                  if (!EmailValidator.validate(value!)){
                    return "please enter the valid email!";
                  }
                  return null;
                },
                onChanged: (value) {
                  emailController.text = value;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (newValue) {
                  email = newValue;
                },
              ),
               
          

                 const SizedBox(height: 15),
                    TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "password",
                hintText: "please enter the password",
                prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
              ),
               ), 
               onChanged: (value) {
                  passwordController.text = value;
                },
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
              decoration: InputDecoration(
                labelText: "password again",
                hintText: "please enter the password again",
                 prefixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                 
                )
              ),
              onChanged: (newValue) {
                  passwordAgainController.text = newValue;
                },
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
                //gizliyo
              ),
                 ], ),
                    ),
                    ), 
                ElevatedButton(onPressed: ()
              {
                if(isLogin){
                  singIn();
                  /*
                Navigator.push(
           context, MaterialPageRoute(
            builder: (context)=>  const HomeScreen(),
              ),);
                */
                }
                else {
                      Navigator.push(
           context, MaterialPageRoute(
            builder: (context)=>  const RegisterScreen(),
              ),);
                }


               
              }, child: isLogin? const Text("login"): const Text("register"),),
                const SizedBox(height: 5),
                  Column(children: [const Text("Don't have a account yet :("),
                 TextButton(child: const Text("please enter the register"),onPressed: () {
                  setState(() {
                    isLogin =!isLogin;
                  });
                 }),],
                 )
               
                
            ],
          ),
        ),
         
       /*Center(child: 
        Text("login")),*/
    );
  }
    }