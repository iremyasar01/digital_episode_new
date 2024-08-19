import 'package:digital_episode_new/widgets/drawer.dart';
import 'package:digital_episode_new/widgets/airing_today_widget.dart';
import 'package:digital_episode_new/widgets/new_series_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    //bildirim ekranı çıkmasın diye telefonun kendi.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
    
  }
  bool isSelected= true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    drawer: const MyDrawer(),
      //önce appbar
     appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 220, 179, 228),
       title: !isSearching? const Text("Episode App",
          style:  TextStyle(color: Color.fromARGB(255, 65, 9, 73)),)
            : TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                autofocus: true,
              ),
      //title: const Text("Episode App",
     //style: TextStyle(color: Color.fromARGB(255, 65, 9, 73)),),
      //buna tıklayınca çıkacak olanlar 
     //watchlist/ all tv shows/ all movies/new series/oturumu kapat/

   

    
     centerTitle: true,
     actions: [
     IconButton(icon: const Icon (Icons.search_rounded),
     onPressed: (){
     
       setState(() {
          isSelected=!isSelected;
           isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear(); // Clear search field when exiting search mode
                }
        });
     }, ),
     const SizedBox(width: 10,),
      IconButton(icon: const Icon(Icons.notifications),
      onPressed: () {
        setState(() {
          isSelected=!isSelected;
        });
      
      },),
      const SizedBox(width:10),    
     ],),
     body: const SingleChildScrollView(
      child: SafeArea(child: 
      Column(children: [
        Padding(padding: 
        EdgeInsets.symmetric(vertical: 13, horizontal: 10),
       child: Row(
        children: [Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("Hello",
          style: TextStyle(color: Color.fromARGB(255, 65, 9, 73), fontSize: 15, fontWeight: FontWeight.w500),),
          Text("What did you watch today?",style: TextStyle(color: Color.fromARGB(255, 65, 9, 73), fontSize: 15, fontWeight: FontWeight.w500),),],
        )],
       ), 
       ),
        SizedBox(height: 15),
        AiringTodayWidget(),
        SizedBox(height:15),
       NewSeriesWidget(),

      ],)),
     ),
      
    );


   
  }
}