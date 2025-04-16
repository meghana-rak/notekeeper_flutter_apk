import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:note_keeper/local_database/local_database.dart';
import 'package:note_keeper/models/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  ///Empty notes list
  List<NoteModel> notes = [];

  ///Load Notes
  Future<void> loadNotes() async {
    notes = await NoteDatabase.instance.getNotes();
    emit(NoteLoaded());
  }

  ///Add Notes or Update as Same Function
  Future<void> addOrUpdateNote(NoteModel note) async {
    if (note.id == null) {
      await NoteDatabase.instance.addNote(note);
    } else {
      await NoteDatabase.instance.updateNote(note);
    }
    await loadNotes();
  }
  ///delete Notes from database
  Future<void> deleteNote(int index) async {
    final note = notes[index];
    await NoteDatabase.instance.deleteNote(note.id!);
    await loadNotes();
  }
}
