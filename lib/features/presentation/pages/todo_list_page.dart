import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../widgets/common/gradient_background.dart';
import '../widgets/common/custom_modal.dart';
import '../widgets/list_page_widgets/todo_item_card.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/list_page_widgets/todo_list_header.dart';
import '../widgets/list_page_widgets/error_state_widget.dart';
import '../widgets/list_page_widgets/custom_fab.dart';
import 'add_todo_page.dart';
import 'todo_detail_page.dart';
import 'onboarding_page.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingPage()),
          );
        }
        return result ?? true;
      } as PopInvokedWithResultCallback<dynamic>?,
      child: Scaffold(
      body: GradientBackground(
        child: SafeArea(
        child: Column(
          children: [
            // Header Section
            const TodoListHeader(),
            // Content Section
            Expanded(
              child: BlocConsumer<TodoBloc, TodoState>(
                listener: (context, state) {
                  if (state is TodoError) {
                    CustomModal.show(
                      context: context,
                      position: ModalPosition.bottom,
                      size: ModalSize.small,
                      title: 'Error',
                      message: state.message,
                      type: ModalType.error,
                      primaryButtonText: 'OK',
                    );
                  } else if (state is TodoOperationSuccess) {
                    CustomModal.show(
                      context: context,
                      position: ModalPosition.bottom,
                      size: ModalSize.small,
                      title: 'Success!',
                      message: state.message,
                      type: ModalType.success,
                      primaryButtonText: 'Great',
                    );
                    // No need to manually reload - bloc handles it automatically
                  }
                },
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else if (state is TodoError) {
                    return ErrorStateWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<TodoBloc>().add(LoadTodosEvent());
                      },
                    );
                  } else if (state is TodosLoaded) {
                    if (state.todos.isEmpty) {
                      return const EmptyStateWidget();
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<TodoBloc>().add(LoadTodosEvent());
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) {
                          final todo = state.todos[index];
                          return TodoItemCard(
                            todo: todo,
                            onTap: () => _navigateToDetail(context, todo.id),
                            onToggle: () => _toggleTodoStatus(context, todo.id),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 16),
        child: CustomFab(
          onPressed: () => _navigateToAddTodo(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
  
  // Navigation helpers
  void _navigateToDetail(BuildContext context, String todoId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<TodoBloc>(),
          child: TodoDetailPage(todoId: todoId),
        ),
      ),
    );
  }
  
  void _navigateToAddTodo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<TodoBloc>(),
          child: const AddTodoPage(),
        ),
      ),
    );
  }
  
  void _toggleTodoStatus(BuildContext context, String id) {
    context.read<TodoBloc>().add(ToggleTodoStatusEvent(id: id));
  }
}
