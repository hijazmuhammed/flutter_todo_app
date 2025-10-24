import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class ToggleTodoStatusParams extends Equatable {
  final String id;
  
  const ToggleTodoStatusParams({required this.id});
  
  @override
  List<Object> get props => [id];
}

class ToggleTodoStatus extends UseCase<Todo, ToggleTodoStatusParams> {
  final TodoRepository repository;
  
  ToggleTodoStatus(this.repository);
  
  @override
  Future<Either<Failure, Todo>> call(ToggleTodoStatusParams params) async {
    return await repository.toggleTodoStatus(params.id);
  }
}
