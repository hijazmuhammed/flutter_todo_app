import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/presentation/pages/onboarding_page.dart';
import 'core/constants/app_colors.dart';
import 'core/network/supabase_client.dart';
import 'injection_container.dart' as di;
import 'features/presentation/bloc/todo_bloc.dart';
import 'features/presentation/bloc/todo_event.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseConfig.initialize();
  
  // Initialize dependencies
  await di.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<TodoBloc>()..add(LoadTodosEvent()),
      child: MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Lexend Deca',
          useMaterial3: true,
        ),
        home: const OnboardingPage(),
      ),
    );
  }
}
