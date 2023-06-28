import 'package:flutter/material.dart';

import '../core/utils/constance/strings_manager.dart';


class CommentList extends StatefulWidget {
  const CommentList({super.key});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  String _text = "";
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
        title:  const Text('Comments',
        style: TextStyle(
        fontFamily: AppStrings.fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 25),
        
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children:  [
                  // const ListTile(
                  //     leading: CircleAvatar(
                  //       //backgroundImage: NetworkImage(comment.userImage),
                  //     ),
                  //     title: Text("Marwan Yasser"),
                  //     subtitle: Text("خخخخخخخ احا يعم"),
                  //   ),
      
                  const SizedBox(height: 10,),
      
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage("https://www.pandasecurity.com/en/mediacenter/src/uploads/2019/07/pandasecurity-How-do-hackers-pick-their-targets.jpg"),
                      ),
                      title: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 69, 69, 69),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                          Text("Marwan Yasser",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text("Hello World",style: TextStyle(color: Colors.white),),
                        ],)
                      ),
                    ),
                    const SizedBox(height: 5,),
                    
                    const SizedBox(height: 85,),
                    ]

            ),

      ),

      floatingActionButton: Container(
        
                      margin: const EdgeInsets.only(left: 35),
                      child: TextField(
                                  controller: _textEditingController,
                                  decoration:  InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(255, 33, 33, 33),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                                    hintText: "Write a comment...",
                                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50) )),
                                    suffixIcon: IconButton(
                                    
                                    icon: const Icon(Icons.send),onPressed: _textEditingController.text == "" ? null : (){

                                    },),
                                    suffixIconColor: _textEditingController.text == "" ? Colors.grey : const Color.fromARGB(255, 0, 255, 13),
                                    
                                  ),
                                  maxLines: 5,
                                  minLines: 1,
                                  onChanged: (value) {
                                    if((_text == "" && value != "") || (_text != "" && value == ""))
                              {
                                setState(() {
                                  
                                });
                              }

                              _text = value;
                                  },
                                ),
                    ),
      
      
    );
  
  }
}
