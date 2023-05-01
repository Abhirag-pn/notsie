import 'package:bloc_test/db/notedb.dart';
import 'package:bloc_test/models/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditingScreen extends StatefulWidget {
  final NoteModel? noteed;
  const EditingScreen({super.key, this.noteed});

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {

  final _formkey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();
    int pickedcolorcode = Colors.blue.value;

  @override
  void initState() {
    if (widget.noteed != null) {
      titleController.text = widget.noteed!.title!;
      descriptionController.text = widget.noteed!.description!;
      pickedcolorcode=widget.noteed!.colorcode;
    } else {
      return;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.done),
        onPressed: () {
          if (widget.noteed == null) {
            bool ste = _formkey.currentState!.validate();
            if (ste) {
              final notetosave = NoteModel(
                  colorcode: pickedcolorcode,
                  title: titleController.text,
                  description: descriptionController.text,
                  date: DateTime.now());
              NoteDb.instance.addNote(notetosave);
              Navigator.pop(context);
            } else {}
          } else {
            widget.noteed!.colorcode = pickedcolorcode;
            widget.noteed!.date = DateTime.now();
            widget.noteed!.title = titleController.text;
            widget.noteed!.description = descriptionController.text;
            bool ste = _formkey.currentState!.validate();
            if (ste) {
              NoteDb.instance.addNote(widget.noteed!);
              Navigator.pop(context);
            } else {}
          }
        },
      ),
      appBar: AppBar(
        title: Text(widget.noteed == null ? "Add Note" : "Edit Note"),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title:const Text("Pick Color"),
                      content: BlockPicker(
                        pickerColor: Color(pickedcolorcode),
                        onColorChanged: (newclr){
                          setState(() {
                            pickedcolorcode=newclr.value;
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                    );
                  });
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Color(pickedcolorcode),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Pick Color",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
        borderRadius: BorderRadius.circular(50),
          ),
        ],
      ),
      body: Container(
        color: Color(pickedcolorcode).withOpacity(0.4),
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                 physics: const BouncingScrollPhysics(),
                children: [
                  TextFormField(
                    
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter title";
                      }
                      return null;
                    },
                    controller: titleController,
                    style: const TextStyle(fontSize: 20),
                    cursorColor: Color(pickedcolorcode),
                    decoration: const InputDecoration(
                      
                      counterText: "",
                      border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        contentPadding: EdgeInsets.zero,
                        hintText: "Titile"),
                    maxLines: 1,
                    maxLength: 60,
                  ),
                  TextFormField(
                    
                     cursorColor: Color(pickedcolorcode),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter description";
                      }
                      return null;
                    },
                    controller: descriptionController,
                    style: const TextStyle(fontSize: 15),
                    decoration: const InputDecoration(
                       isDense: true,
                       border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        contentPadding: EdgeInsets.zero,
                        hintText: "Description"),
                    maxLines: null,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
