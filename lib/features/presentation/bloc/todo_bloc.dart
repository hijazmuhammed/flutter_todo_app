import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todo_detail.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/toggle_todo_status.dart';
import '../../domain/usecases/update_todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final GetTodoDetail getTodoDetail;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;
  final ToggleTodoStatus toggleTodoStatus;
  
  TodoBloc({
    required this.getTodos,
    required this.getTodoDetail,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
    required this.toggleTodoStatus,
  }) : super(TodoInitial()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<ToggleTodoStatusEvent>(_onToggleTodoStatus);
    on<LoadTodoDetailEvent>(_onLoadTodoDetail);
  }
  
  Future<void> _onLoadTodos(
    LoadTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    
    final result = await getTodos( NoParams());
    
    result.fold(
      (failure) => emit(TodoError(message: failure.message)),
      (todos) => emit(TodosLoaded(todos: todos)),
    );
  }
  
  Future<void> _onAddTodo(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    
    final result = await addTodo(AddTodoParams(
      title: event.title,
      description: event.description,
    ));
    
    await result.fold(
      (failure) async => emit(TodoError(message: failure.message)),
      (todo) async {
        emit(const TodoOperationSuccess(message: 'Todo added successfully'));
        // Reload todos list
        final todosResult = await getTodos(NoParams());
        todosResult.fold(
          (failure) => emit(TodoError(message: failure.message)),
          (todos) => emit(TodosLoaded(todos: todos)),
        );
      },
    );
  }
  
  Future<void> _onUpdateTodo(
    UpdateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    
    final result = await updateTodo(UpdateTodoParams(todo: event.todo));
    
    await result.fold(
      (failure) async => emit(TodoError(message: failure.message)),
      (todo) async {
        emit(const TodoOperationSuccess(message: 'Todo updated successfully'));
        // Reload todos list
        final todosResult = await getTodos(NoParams());
        todosResult.fold(
          (failure) => emit(TodoError(message: failure.message)),
          (todos) => emit(TodosLoaded(todos: todos)),
        );
      },
    );
  }
  
  Future<void> _onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    
    final result = await deleteTodo(DeleteTodoParams(id: event.id));
    
    await result.fold(
      (failure) async => emit(TodoError(message: failure.message)),
      (_) async {
        emit(const TodoOperationSuccess(message: 'Todo deleted successfully'));
        // Reload todos list
        final todosResult = await getTodos(NoParams());
        todosResult.fold(
          (failure) => emit(TodoError(message: failure.message)),
          (todos) => emit(TodosLoaded(todos: todos)),
        );
      },
    );
  }
  
  Future<void> _onToggleTodoStatus(
    ToggleTodoStatusEvent event,
    Emitter<TodoState> emit,
  ) async {
    // Don't show loading state for quick toggle action
    final result = await toggleTodoStatus(ToggleTodoStatusParams(id: event.id));
    
    await result.fold(
      (failure) async => emit(TodoError(message: failure.message)),
      (todo) async {
        // Directly reload todos list without showing success message
        final todosResult = await getTodos(NoParams());
        todosResult.fold(
          (failure) => emit(TodoError(message: failure.message)),
          (todos) => emit(TodosLoaded(todos: todos)),
        );
      },
    );
  }
  
  Future<void> _onLoadTodoDetail(
    LoadTodoDetailEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    
    final result = await getTodoDetail(GetTodoDetailParams(id: event.id));
    
    result.fold(
      (failure) => emit(TodoError(message: failure.message)),
      (todo) => emit(TodoDetailLoaded(todo: todo)),
    );
  }
}
