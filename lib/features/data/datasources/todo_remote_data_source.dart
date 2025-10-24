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
  final SupabaseClient client;
  
  TodoRemoteDataSourceImpl({required this.client});
  
  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      final response = await client
          .from('todos')
          .select()
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((json) => TodoModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<TodoModel> getTodoById(String id) async {
    try {
      final response = await client
          .from('todos')
          .select()
          .eq('id', id)
          .single();
      
      return TodoModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<TodoModel> addTodo({required String title, required String description}) async {
    try {
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
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    try {
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
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<void> deleteTodo(String id) async {
    try {
      await client
          .from('todos')
          .delete()
          .eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<TodoModel> toggleTodoStatus(String id) async {
    try {
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
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
