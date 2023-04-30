import 'package:bloc_test/models/notemodel.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDb {
  Isar? notedb;
  NoteDb.initialise();
  static final instance = NoteDb.initialise();
  factory NoteDb() {
    return instance;
  }

  Future<void> initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    notedb = await Isar.open(
      [NoteModelSchema],
      directory: dir.path,
    );
  }

  Stream<List<NoteModel>> getallNotes() {
    return notedb!.noteModels.where().watch(fireImmediately: true);
  }

  Future<void> addNote(NoteModel note) async {
    await notedb!.writeTxn(() async {
      await notedb!.noteModels.put(note);
    });
  }

  Future<void> delNote(Id id) async {
    await notedb!.writeTxn(() async {
      notedb!.noteModels.delete(id);
    });
  }
}
