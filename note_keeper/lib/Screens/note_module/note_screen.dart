import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_keeper/Constants/CommonColors.dart';
import 'package:note_keeper/Screens/login_module/login_screen.dart';
import 'package:note_keeper/Screens/note_module/note_cubit.dart';
import 'package:note_keeper/models/note_model.dart';
import 'package:note_keeper/utils/CommonButton.dart';
import 'package:note_keeper/utils/Routes/navigation_service.dart';
import 'package:note_keeper/utils/shared_data.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      ///App Bar Titile and Logout button
      appBar: AppBar(
        title: const Text('My Notes'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              await SharedData.instance.remove('isLoggedIn');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout successful!')),
              );
              NavigationService().pushReplacement(context, LoginScreen());
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {

          ///if Notes or not in Database then show this error
          if (cubit.notes.isEmpty) {
            return Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.note_alt_outlined,
                        size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 12),
                    Text(
                      "No Notes Available",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "You don't have any notes yet.\nStart by adding a new one!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          ///if Notes are in Database then show this List With Box Wise
          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            padding: const EdgeInsets.all(16),
            itemCount: cubit.notes.length,
            itemBuilder: (context, index) {
              final note = cubit.notes[index];
              return GestureDetector(
                onTap: () => showNoteBottomSheet(context, cubit, note: note),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    // backdropFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((note.title ?? '').isNotEmpty)
                        Text(
                          note.title!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black87,
                          ),
                        ),
                      const SizedBox(height: 10),
                      Text(
                        note.content ?? '',
                        style: const TextStyle(
                          fontSize: 14.5,
                          color: Colors.black54,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined,
                                size: 20, color: Colors.indigo),
                            onPressed: () =>
                                showNoteBottomSheet(context, cubit, note: note),
                            tooltip: 'Edit',
                            visualDensity: VisualDensity.compact,
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded,
                                size: 20, color: Colors.redAccent),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Delete Note'),
                                  content: const Text(
                                      'Are you sure you want to delete this note?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        cubit.deleteNote(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            tooltip: 'Delete',
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      ///Add and Update button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNoteBottomSheet(context, cubit);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  ///This is separate bottom sheet for update and add notes
  Future<void> showNoteBottomSheet(BuildContext context, NoteCubit cubit,
      {NoteModel? note}) async {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                note == null ? 'Add Note' : 'Edit Note',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              CommonButton(
                onTap: () async {
                  final newNote = NoteModel(
                    id: note?.id,
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                  );
                  await cubit.addOrUpdateNote(newNote);
                  Navigator.pop(context);
                },
                color: CommonColors.blueColour,
                title: note == null ? 'Save Note' : 'Update Note',
                padding: EdgeInsets.all(10),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
