import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/exceptions.dart';
import '../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
  Future<TodoModel> getTodoById(String id);
  Future<TodoModel> addTodo({required String title, required String description});
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
  Future<TodoModel> toggleTodoStatus(String id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final SupabaseClient? client; // Made optional for mock data
  
  TodoRemoteDataSourceImpl({this.client});
  
  // Mock data based on Figma design
  static final List<TodoModel> _mockTodos = [
    TodoModel(
      id: '1',
      title: 'Office Project',
      description: 'Has to do some optimisation',
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    TodoModel(
      id: '2',
      title: 'Personal Project',
      description: 'Work on personal development goals',
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    TodoModel(
      id: '3',
      title: 'Daily Study',
      description: 'Complete Flutter course chapter 5',
      isCompleted: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    TodoModel(
      id: '4',
      title: 'Daily Study',
      description: 'Review React Native documentation',
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];
  
  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Return mock data instead of Supabase call
      return List.from(_mockTodos);
      
      /* Supabase implementation (commented out)
      final response = await client
          .from('todos')
          .select()
          .order('created_at', ascending: false);
      
      return response
          .map((json) => TodoModel.fromJson(json))
          .toList();
      */
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<TodoModel> getTodoById(String id) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      
      // Find todo in mock data
      final todo = _mockTodos.firstWhere((todo) => todo.id == id);
      return todo;
      
      /* Supabase implementation (commented out)
      final response = await client
          .from('todos')
          .select()
          .eq('id', id)
          .single();
      
      return TodoModel.fromJson(response);
      */
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<TodoModel> addTodo({required String title, required String description}) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 400));
      
      // Create new todo with mock data
      final newTodo = TodoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        isCompleted: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      // Add to mock data
      _mockTodos.insert(0, newTodo);
      return newTodo;
      
      /* Supabase implementation (commented out)
      final response = await client
          .from('todos')
          .insert({
            'title': title,
            'description': description,
            'is_completed': false,
          })
          .select()
          .single();
      
      return TodoModel.fromJson(response);
      */
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 400));
      
      // Find and update todo in mock data
      final index = _mockTodos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        final updatedTodo = TodoModel(
          id: todo.id,
          title: todo.title,
          description: todo.description,
          isCompleted: todo.isCompleted,
          createdAt: todo.createdAt,
          updatedAt: DateTime.now(),
        );
        _mockTodos[index] = updatedTodo;
        return updatedTodo;
      }
      throw const ServerException('Todo not found');
      
      /* Supabase implementation (commented out)
      final response = await client
          .from('todos')
          .update({
            'title': todo.title,
            'description': todo.description,
            'is_completed': todo.isCompleted,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', todo.id)
          .select()
          .single();
      
      return TodoModel.fromJson(response);
      */
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<void> deleteTodo(String id) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      
      // Remove todo from mock data
      _mockTodos.removeWhere((todo) => todo.id == id);
      
      /* Supabase implementation (commented out)
      await client
          .from('todos')
          .delete()
          .eq('id', id);
      */
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<TodoModel> toggleTodoStatus(String id) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      
      // Find and toggle todo status in mock data
      final index = _mockTodos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        final currentTodo = _mockTodos[index];
        final updatedTodo = TodoModel(
          id: currentTodo.id,
          title: currentTodo.title,
          description: currentTodo.description,
          isCompleted: !currentTodo.isCompleted,
          createdAt: currentTodo.createdAt,
          updatedAt: DateTime.now(),
        );
        _mockTodos[index] = updatedTodo;
        return updatedTodo;
      }
      throw const ServerException('Todo not found');
      
      /* Supabase implementation (commented out)
      // First get the current todo
      final currentTodo = await getTodoById(id);
      
      // Update with toggled status
      final updatedTodo = TodoModel(
        id: currentTodo.id,
        title: currentTodo.title,
        description: currentTodo.description,
        isCompleted: !currentTodo.isCompleted,
        createdAt: currentTodo.createdAt,
        updatedAt: DateTime.now(),
      );
      
      return await updateTodo(updatedTodo);
      */
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
