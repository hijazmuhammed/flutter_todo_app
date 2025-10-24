import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String url = 'https://psqpdlkmmqcivxhqslan.supabase.co';
  static const String anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBzcXBkbGttbXFjaXZ4aHFzbGFuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEzMjc1MTksImV4cCI6MjA3NjkwMzUxOX0.K8244UnuaT8ymNbKv7lk8QqMtMBAqKyS_D5zf3JzrqY';
  
  static SupabaseClient get client => Supabase.instance.client;
  
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }
}
