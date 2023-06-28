import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/constance/strings_manager.dart';


class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations',
        style: TextStyle(
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
      children: [
      Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network("https://dailypost.ng/wp-content/uploads/2022/08/Rio-Ferdinand-scaled.jpg",
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              AppStrings.error1Gif,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress != null) {
                                              return Image.asset(
                                                AppStrings.loading1Gif,
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            return child;
                                          },
                                    )
                                  ),
                                ),
                          const SizedBox(width: 10.0),
                          const Text(
                                    "Mahmoud Hamdy",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                          
                          
                        ],
                      ),

                      IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          // Implement cancellation logic here
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        children:   [
                          Text('Reservation for',style:GoogleFonts.acme(fontSize: 16)),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration:  BoxDecoration(
                              color: Theme.of(context).colorScheme.onTertiaryContainer,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    //offset: Offset(4,4),
                  ),
                ]
                            ),
                            height: 30,
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text("5",style: GoogleFonts.acme(fontSize: 17,color: Colors.green,fontWeight: FontWeight.bold),),
                                Text(" Adults",style: GoogleFonts.acme(fontSize: 16.5),),
                              ],
                            ),
                          ),
                          Text('and',style:GoogleFonts.acme(fontSize: 16)),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration:  BoxDecoration(
                              color: Theme.of(context).colorScheme.onTertiaryContainer,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    //offset: Offset(4,4),
                  ),
                ]
                            ),
                            height: 30,
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text("6",style: GoogleFonts.acme(fontSize: 17,color: Colors.green,fontWeight: FontWeight.bold),),
                                Text(" Kids",style: GoogleFonts.acme(fontSize: 16.5),),
                              ],
                            ),
                          
                          
                          ),
                        
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                        Column(
                          children: [
                            Text("Check-In Date",style: GoogleFonts.acme(fontSize: 16)),
                            const SizedBox(height: 5,),
                            Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width*0.35,
                                    decoration:  BoxDecoration(color: Theme.of(context).colorScheme.onTertiaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    //offset: Offset(4,4),
                  ),
                ]
                                    ),
                                    child:  Center(child: Text('9/8/2023',style: GoogleFonts.acme(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),))),
                          ],
                        ),
                              Column(
                                
                                children: [
                                  Text("Check-Out Date",style: GoogleFonts.acme(fontSize: 16,),),
                            const SizedBox(height: 5,),
                                  Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width*0.35,
                                    decoration:  BoxDecoration(color: Theme.of(context).colorScheme.onTertiaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    //offset: Offset(4,4),
                  ),
                ]
                                    ),
                                    
                                    child: Center(child: Text('12/8/2023',style: GoogleFonts.acme(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),))),
                                ],
                              ),
                        ],),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                        Column(
                          children: [
                            Text("Request Time",style: GoogleFonts.acme(fontSize: 16,),),
                            const SizedBox(height: 5,),
                            Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width*0.35,
                                    decoration:  BoxDecoration(color: Theme.of(context).colorScheme.onTertiaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    //offset: Offset(4,4),
                  ),
                ]
                                    ),
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        Text('6/8/2023',style: GoogleFonts.acme(fontSize: 17,color: Colors.green,fontWeight: FontWeight.bold),),
                                        Text(' | ',style: GoogleFonts.acme(fontSize: 17),),
                                        Text('01:33',style: GoogleFonts.acme(fontSize: 17,color: Colors.green,fontWeight: FontWeight.bold),),
                                      ],
                                    ))
                          ],
                        ),
                              Column(
                                
                                children: [
                                  Text("Phone Number",style: GoogleFonts.acme(fontSize: 16),),
                            const SizedBox(height: 5,),
                                  Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width*0.35,
                                    decoration:  BoxDecoration(color: Theme.of(context).colorScheme.onTertiaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    //offset: Offset(4,4),
                  ),
                ]
                                    ),
                                    child: Center(child: Text('01058973641',style: GoogleFonts.acme(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),))),
                                ],
                              ),
                        ],),
                      
        ],
                  ),
                ],
              ),
            ),
          ),
        
      ],
      ),
    );
  }
}

