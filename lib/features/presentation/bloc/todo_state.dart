import 'package:equatable/equatable.dart';
import '../../domain/entities/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodosLoaded extends TodoState {
  final List<Todo> todos;
  
  const TodosLoaded({required this.todos});
  
  @override
  List<Object> get props => [todos];
}

class TodoDetailLoaded extends TodoState {
  final Todo todo;
  
  const TodoDetailLoaded({required this.todo});
  
  @override
  List<Object> get props => [todo];
}

class TodoOperationSuccess extends TodoState {
  final String message;
  
  const TodoOperationSuccess({required this.message});
  
  @override
  List<Object> get props => [message];
}

class TodoError extends TodoState {
  final String message;
  
  const TodoError({required this.message});
  
  @override
  List<Object> get props => [message];
}
