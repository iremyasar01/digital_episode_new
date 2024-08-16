
import 'package:digital_episode_new/components/my_users_model.dart';
import 'package:digital_episode_new/services/auth.dart';
import 'package:digital_episode_new/widgets/My_appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
//profile ekranında ad soyad istesin maili gçstersin tel no iste.uğdate buttondan ekran yap firebasedem çek
class _ProfileScreenState extends State<ProfileScreen> {
 //late TextEditingController emailController;
  //late TextEditingController usernameController;
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController passwordAgainController;
    
      @override
  void initState() {
    super.initState();
    
    // Kullanıcı bilgilerini Firestore'dan çekip controller'lara atıyoruz
    Auth().getMyUsersAsStream().listen((userModel) {
      setState(() {
        nameController = TextEditingController(text: userModel.name);
        surnameController = TextEditingController(text: userModel.surname);
        phoneNumberController = TextEditingController(text: userModel.phoneNumber);
         passwordController = TextEditingController(text: userModel.password);
          passwordAgainController = TextEditingController(text: userModel.passwordAgain);
      });
    });
  }
  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    nameController.dispose();
    surnameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    super.dispose();
  }

     Widget inputWidget(
      {TextEditingController? controller,String? labelText, String? newValue, bool? readOnly = false,}) {
        
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white38, width: 1.5));
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
         border: border, enabledBorder: border, focusedBorder: border),
           onChanged: (value) {
            newValue = value;
           },   
      ),
    );
  }
  @override
  Widget build(BuildContext context) {


    return  Scaffold(
        appBar: const MyAppBar(), 
      backgroundColor: const Color.fromARGB(255, 222, 162, 233),
      //floatingActionButton: FloatingActionButton(
        //  onPressed: () => Navigator.of(context).pushNamed("/action",
          //    arguments: (id, ActionType.insert, null, null, null)),
          //child: const Icon(
            //Icons.add,
            //color: Colors.white,
            //size: 30,
          //)),
     body: Padding(padding: const EdgeInsets.all(20),
     child: SingleChildScrollView(
   child: StreamBuilder<MyUsersModel>(
    stream: Auth().getMyUsersAsStream(), 
    builder:(context, snapshot) {
      //verimizi alalım.
      //verimin türü usersModels
      //verim null da olabilir.
      //verimin gelip gelmediğinin kontrolü
      if(snapshot.connectionState == ConnectionState.waiting){
        //eğer verim gelirse verimin gelmesini beklerken circle ekranını getir.
        return const CircularProgressIndicator();
      }
       if (snapshot.hasError) {
      return Text("Error: ${snapshot.error}"); // Hata durumunda gösterilecek widget
    }
        if (snapshot.hasData) {
      MyUsersModel? myUsersModel = snapshot.data;
      // Verileri UI'da gösterme
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
          child: Center(
            child: Column(
              children: [
                inputWidget( controller: TextEditingController(text: myUsersModel?.email),
                      labelText: "Email" ),

                     // hintText: "${myUsersModel?.email}"),
                  //labelText:"email" , hintText: "${myUsersModel?.email}"   ),
                inputWidget(controller: TextEditingController(text: myUsersModel?.username),labelText:"username" ,  ),
                inputWidget(controller: nameController,newValue:  myUsersModel?.name,labelText:"name" , ),
                inputWidget(controller: surnameController, newValue:  myUsersModel?.surname,labelText:"surname" ,   ),
                inputWidget(controller: phoneNumberController, newValue: myUsersModel?.phoneNumber,labelText:"phone number" , ),
                inputWidget(controller: passwordController, newValue:  myUsersModel?.password,labelText:"password" ,    ),
                 inputWidget(controller: passwordAgainController, newValue:  myUsersModel?.passwordAgain,labelText:"password again" ,    ),

                 ElevatedButton(onPressed: (){
                   // Bilgileri güncelle
                      Auth().updateUser(
      
                        name: nameController.text,
                        surname: surnameController.text,
                        phoneNumber: phoneNumberController.text,
                        password: passwordController.text,);
                 }, child: const Text("Edit"),),
                /*
                Text("Email: ${myUsersModel?.email}",),
                Text("Username: ${myUsersModel?.username}"),
                Text("name: ${myUsersModel?.name}"),
                Text("surname: ${myUsersModel?.surname}"),
                Text("phoneNumber: ${myUsersModel?.phoneNumber}"),
                Text("password: ${myUsersModel?.password}"),
                //Text("passwordAgain: ${myUsersModel?.passwordAgain}"),
            
                // Diğer verileri burada göster
                */
              ],
            ),
          ),
        );
  
    } else {
      return const Text("No data available"); // Veriler gelmezse gösterilecek widget
            }
            },
          ),
        ),
      ),
    );
  }
}

    


    
 
   
     
  
  



   
  
   
    
    
     //List.generate(MyUsersModel!. myUsersModel.myUsersModel[index] {
     //final MyUsersModel myUsersModel = usersModels.usersModels[index];
      //return MyProfile(id: myUsersModel.id, email: myUsersModel.email, username: myUsersModel.username, name: myUsersModel.name, surname: myUsersModel.surname, phoneNumber: myUsersModel.phoneNumber, password: myUsersModel.password, passwordAgain: myUsersModel.passwordAgain,);
    //}),

      

  
      //eğer bunu FutureBuilder yaparsam veriyi bir kere çeker güncellediğimde göstermez
      //o yüzden stream ile yapmam gerekir.
      /*
      child: FutureBuilder<UsersModels>(
    future: FirebaseServices().getMyUsers(id), builder:(context, snapshot) {
      //verimizi alalım.
      //verimin türü usersModels
      //verim null da olabilir.
      final UsersModels? usersModels = snapshot.data;
      //verimin gelip gelmediğinin kontrolü
      if(snapshot.connectionState == ConnectionState.waiting){
        //eğer verim gelirse verimin gelmesini beklerken circle ekranını getir.
        return const CircularProgressIndicator();

      }
      //eğer verim gelirse list oluştur.
     return Column(
    children: List.generate(usersModels!.usersModels.length,(index) {
      final MyUsersModel myUsersModel = usersModels.usersModels[index];
      return MyProfile(id: myUsersModel.id, email: myUsersModel.email, username: myUsersModel.username, name: myUsersModel.name, surname: myUsersModel.surname, phoneNumber: myUsersModel.phoneNumber, password: myUsersModel.password, passwordAgain: myUsersModel.passwordAgain,);
    }),
     );

    */

