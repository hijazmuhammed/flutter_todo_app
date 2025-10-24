import 'package:get_it/get_it.dart';
import 'core/network/supabase_client.dart';
import 'features/data/datasources/todo_remote_data_source.dart';
import 'features/data/repositories/todo_repository_impl.dart';
import 'features/domain/repositories/todo_repository.dart';
import 'features/domain/usecases/add_todo.dart';
import 'features/domain/usecases/delete_todo.dart';
import 'features/domain/usecases/get_todo_detail.dart';
import 'features/domain/usecases/get_todos.dart';
import 'features/domain/usecases/toggle_todo_status.dart';
import 'features/domain/usecases/update_todo.dart';
import 'features/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => TodoBloc(
    getTodos: sl(),
    getTodoDetail: sl(),
    addTodo: sl(),
    updateTodo: sl(),
    deleteTodo: sl(),
    toggleTodoStatus: sl(),
  ));
  
  // Use Cases
  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => GetTodoDetail(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => ToggleTodoStatus(sl()));
  
  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(remoteDataSource: sl()),
  );
  
  // Data Sources
  sl.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(client: SupabaseConfig.client),
  );
  
  // External
  sl.registerLazySingleton(() => SupabaseConfig.client);
}
