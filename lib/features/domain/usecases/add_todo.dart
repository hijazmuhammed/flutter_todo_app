import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class AddTodoParams extends Equatable {
  final String title;
  final String description;
  
  const AddTodoParams({
    required this.title,
    required this.description,
  });
  
  @override
  List<Object> get props => [title, description];
}

class AddTodo extends UseCase<Todo, AddTodoParams> {
  final TodoRepository repository;
  
  AddTodo(this.repository);
  
  @override
  Future<Either<Failure, Todo>> call(AddTodoParams params) async {
    return await repository.addTodo(
      title: params.title,
      description: params.description,
    );
  }
}
