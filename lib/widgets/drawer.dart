import 'package:digital_episode_new/components/my_list_tile.dart';
import 'package:digital_episode_new/screens/all_movies_screen.dart';
import 'package:digital_episode_new/screens/all_tv_shows_screen.dart';
import 'package:digital_episode_new/screens/favorites_screen.dart';
import 'package:digital_episode_new/screens/home_screen.dart';
import 'package:digital_episode_new/screens/login_screen.dart';
//import 'package:digital_episode_new/screens/login_screen.dart';
import 'package:digital_episode_new/screens/new_series_screen.dart';
import 'package:digital_episode_new/screens/profile_screen.dart';
import 'package:digital_episode_new/screens/watchlist_screen.dart';
import 'package:digital_episode_new/services/auth.dart';
//import 'package:digital_episode_new/screens/login_screen.dart';
//import 'package:digital_episode_new/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/navigator.dart';
class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: const Color.fromARGB(255, 235, 182, 244),
      child: Column(
        children: [ const DrawerHeader
        (child: Icon(Icons.person,
        color: Colors.white,
        size: 24,),
        ),
         MyListTile(icon:Icons.person ,text: "profile",  onTap: () =>
        Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => const ProfileScreen())) ),
         MyListTile(icon:Icons.home ,text: "home",  onTap: () =>
        Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => const HomeScreen())) ),
        MyListTile(icon: Icons.tv, text:"WatchList",onTap: () =>
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => const WatchlistScreen())) ),
        MyListTile(text: "Favorites",icon: Icons.heart_broken,onTap: () =>Navigator.push(context,MaterialPageRoute(builder: (context) => const FavoritesScreen()))),
        MyListTile(text: "All Tv Shows",icon: Icons.tv_sharp,onTap: () =>
        Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => const AllTvShowsScreen()))),
        MyListTile(text: "All Movies",icon: Icons.movie,onTap: () =>
        Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => const AllMoviesScreen())) ),
        MyListTile( text: "New series",icon: Icons.tv_outlined,onTap: () =>
        Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => const NewSeriesScreen())) ),
        MyListTile( text: "log out",icon: Icons.exit_to_app_outlined,onTap: () {
               Auth().singOut();
          Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (Route<dynamic> route) => false,
    );
    
        }
   
         
        ),

      
        ],
       
      ),);
  }
}