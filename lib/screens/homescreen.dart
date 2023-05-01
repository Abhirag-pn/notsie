import 'package:bloc_test/db/notedb.dart';

import 'package:bloc_test/screens/editing_screen.dart';
import 'package:bloc_test/widgets/note_list_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool onlyStarred=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const EditingScreen();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Notesie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              
               customBorder:RoundedRectangleBorder(borderRadius:  BorderRadius.circular(10),) ,
              
              onTap: (){
                setState(() {
                  onlyStarred=!onlyStarred;
                });
              },
              child: Chip(backgroundColor:onlyStarred?Colors.blue:null,label: Text("Starred",style: TextStyle(color: onlyStarred?Colors.white:null),
              )),
            ),
            Expanded(
                child: StreamBuilder(
              stream: NoteDb.instance.getallNotes(onlyStarred),
              builder: (context, notes) {
                if (notes.connectionState == ConnectionState.active ||
                    notes.connectionState == ConnectionState.done) {
                  if (notes.hasData &&
                      notes.data != null &&
                      notes.data!.isNotEmpty) {
                    return  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return NoteItem(
                            note: notes.data![index],
                          );
                        },
                        itemCount: notes.data!.length,
                      
                    );
                  } else {
                    return Center(
                        child: Text(
                          !onlyStarred?
                      "No Notes Found":"No Starred Notes",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ));
                  }
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                   
                  ));
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
