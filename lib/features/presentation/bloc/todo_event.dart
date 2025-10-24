import 'package:equatable/equatable.dart';
import '../../domain/entities/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  
  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;
  
  const AddTodoEvent({
    required this.title,
    required this.description,
  });
  
  @override
  List<Object> get props => [title, description];
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;
  
  const UpdateTodoEvent({required this.todo});
  
  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  
  const DeleteTodoEvent({required this.id});
  
  @override
  List<Object> get props => [id];
}

class ToggleTodoStatusEvent extends TodoEvent {
  final String id;
  
  const ToggleTodoStatusEvent({required this.id});
  
  @override
  List<Object> get props => [id];
}

class LoadTodoDetailEvent extends TodoEvent {
  final String id;
  
  const LoadTodoDetailEvent({required this.id});
  
  @override
  List<Object> get props => [id];
}
