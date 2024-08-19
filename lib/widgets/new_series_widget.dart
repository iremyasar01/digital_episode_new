import 'package:flutter/material.dart';

class NewSeriesWidget extends StatelessWidget {
  const NewSeriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column( children: [
       const Padding( padding:EdgeInsets.symmetric(horizontal: 10),
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: 
        [Text("New Series",
        style: TextStyle(color: Color.fromARGB(255, 65, 9, 73),
        fontSize: 20,
        fontWeight: FontWeight.w500),),
         Text("see all",
            style: TextStyle(color: Color.fromARGB(255, 65, 9, 73),
            fontSize: 15),
            ),
        ],
        
      ),
      ),
     const SizedBox(height: 10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for(int i =1; i<6; i++)
            InkWell(
              onTap: (){},
              child: Container(
                width: 190,
                height: 260,
                margin: const EdgeInsets.only(left: 10) ,
                decoration: BoxDecoration(color: const Color(0xFF292B37),
                borderRadius: BorderRadius.circular(10),
                boxShadow:[BoxShadow(color: const Color(0xFF292B37).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 6,),],),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),),
                    child: Image.asset("assets/images/tv/new$i.png",
                    height: 180,
                    width: 200,
                    fit: BoxFit.cover,),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10,
                    horizontal: 5,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star,
                            color: Colors.amber),
                            SizedBox(width: 5),
                            Text("8.5",
                            style: TextStyle(color: Colors.white,
                            fontSize: 16,),)
                          ],
                        ),
                        SizedBox(height: 5),
                        Text("movie title",
                        style: TextStyle(color: Colors.white),)

                      ],
                    ),)
                    
                  


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    
    ],
     
    );
  }
}