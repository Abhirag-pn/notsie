import 'package:bloc_test/models/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/notedb.dart';
import '../screens/editing_screen.dart';

class NoteItem extends StatefulWidget {
  final NoteModel note;

  const NoteItem({
    super.key,
    required this.note,
  });

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
 



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 10,
              width: 10,
              color: Color(widget.note.colorcode),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.note.title!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    widget.note.description!,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    textWidthBasis: TextWidthBasis.longestLine,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Text(
                  DateFormat.MMMEd().format(widget.note.date),
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            const Spacer(),
          InkWell(
             customBorder:RoundedRectangleBorder(borderRadius:  BorderRadius.circular(10),) ,
              
            onTap: (){
            
            setState(() {
             widget.note.isStarred= !widget.note.isStarred; 
              NoteDb.instance.addNote(widget.note);
            });

          }, child: Icon(widget.note.isStarred?Icons.star:Icons.star_border)),
           const  SizedBox(width: 8,),
            InkWell(
               customBorder:RoundedRectangleBorder(borderRadius:  BorderRadius.circular(10),) ,
              
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditingScreen(
                      noteed: widget.note,
                    );
                  }));
                },
                child: const Icon(Icons.edit)),
                 const  SizedBox(width: 8,),
            InkWell(
              customBorder:RoundedRectangleBorder(borderRadius:  BorderRadius.circular(10),) ,
              
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (
                        context,
                      ) {
                        return AlertDialog(
                          actionsPadding: const EdgeInsets.only(bottom: 20),
                          alignment: Alignment.center,
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          title: Text(
                            "Are You Sure ?",
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                            "Do you want to delete this note",
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            InkWell(
                               customBorder:RoundedRectangleBorder(borderRadius:  BorderRadius.circular(10),) ,
              
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(color: Colors.black),
                                )),
                            InkWell(
                               customBorder:RoundedRectangleBorder(borderRadius:  BorderRadius.circular(10),) ,
              
                                onTap: () {
                                  NoteDb.instance.delNote(widget.note.id);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        );
                      });
                },
                child: const Icon(Icons.delete)),
              const  SizedBox(width: 8,)
          ],
        ),
      ),
    );
  }
}
