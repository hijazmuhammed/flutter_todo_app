import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodos extends UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;
  
  GetTodos(this.repository);
  
  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getTodos();
  }
}
