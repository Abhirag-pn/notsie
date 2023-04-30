import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
part 'notemodel.g.dart';

@collection
class NoteModel {
  Id id = Isar.autoIncrement;
  String? title, description;
  DateTime date;
  int colorcode = Colors.blue.value;

  NoteModel(
      {required this.title,
      required this.description,
      required this.date,
      required this.colorcode,
      });
}
