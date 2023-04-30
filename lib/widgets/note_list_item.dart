import 'package:bloc_test/models/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/notedb.dart';
import '../screens/editing_screen.dart';

class NoteItem extends StatelessWidget {
  final NoteModel note;

  const NoteItem({
    super.key,
    required this.note,
  });

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
              color: Color(note.colorcode),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    note.description!,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    textWidthBasis: TextWidthBasis.longestLine,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Text(
                  DateFormat.MMMEd().format(note.date),
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            const Spacer(),
          InkWell(onTap: (){}, child: Icon(Icons.star)),
           const  SizedBox(width: 8,),
            InkWell(
              
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditingScreen(
                      noteed: note,
                    );
                  }));
                },
                child: const Icon(Icons.edit)),
                 const  SizedBox(width: 8,),
            InkWell(
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
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(color: Colors.black),
                                )),
                            InkWell(
                                onTap: () {
                                  NoteDb.instance.delNote(note.id);
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
                child: const Icon(Icons.delete_outline_sharp)),
              const  SizedBox(width: 8,)
          ],
        ),
      ),
    );
  }
}
