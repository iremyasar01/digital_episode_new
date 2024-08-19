import 'package:flutter/material.dart';

class AiringTodayWidget extends StatelessWidget {
  const AiringTodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
       const Padding(padding: 
        EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Airing Today",
            style: TextStyle(color: Color.fromARGB(255, 65, 9, 73),
            fontSize: 20,
            fontWeight: FontWeight.w500),
            ),
            Text("see all",
            style: TextStyle(color: Color.fromARGB(255, 65, 9, 73),
            fontSize: 15),
            ),
          ],
        ),),
         const SizedBox(height: 15),
         SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for(int i =1; i<7; i++)
              Padding(padding: const EdgeInsets.only(left: 10),
              child: ClipRRect(borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/images/tv/up$i.png"
              , height: 300,
               width: 200,
              fit: BoxFit.cover ),
              ),)
            ],
          ),
         )

      ],
    );
  }
}