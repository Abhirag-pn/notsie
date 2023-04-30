import 'package:bloc_test/db/notedb.dart';

import 'package:bloc_test/screens/editing_screen.dart';
import 'package:bloc_test/widgets/note_list_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: StreamBuilder(
            stream: NoteDb.instance.getallNotes(),
            builder: (context, notes) {
              if (notes.connectionState == ConnectionState.active ||
                  notes.connectionState == ConnectionState.done) {
                if (notes.hasData &&
                    notes.data != null &&
                    notes.data!.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return NoteItem(note: notes.data![index],
                        );
                      },
                      itemCount: notes.data!.length,
                    ),
                  );
                } else {
                  return const Center(
                      child: Text(
                    "No Notes Found",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ));
                }
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ));
              }
            },
          )),
    );
  }
}
