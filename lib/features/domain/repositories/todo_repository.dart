import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, Todo>> getTodoById(String id);
  Future<Either<Failure, Todo>> addTodo({
    required String title,
    required String description,
  });
  Future<Either<Failure, Todo>> updateTodo(Todo todo);
  Future<Either<Failure, void>> deleteTodo(String id);
  Future<Either<Failure, Todo>> toggleTodoStatus(String id);
}
