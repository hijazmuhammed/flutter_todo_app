import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodoDetailParams extends Equatable {
  final String id;
  
  const GetTodoDetailParams({required this.id});
  
  @override
  List<Object> get props => [id];
}

class GetTodoDetail extends UseCase<Todo, GetTodoDetailParams> {
  final TodoRepository repository;
  
  GetTodoDetail(this.repository);
  
  @override
  Future<Either<Failure, Todo>> call(GetTodoDetailParams params) async {
    return await repository.getTodoById(params.id);
  }
}
