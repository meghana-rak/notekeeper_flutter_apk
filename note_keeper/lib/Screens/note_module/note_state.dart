part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {}

final class NoteDelete extends NoteState {}

final class NoteAddOrDelete extends NoteState {}

final class NoteDetailsNavigate extends NoteState {}
