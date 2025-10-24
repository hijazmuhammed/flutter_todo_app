import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_state.dart';
import '../widgets/common/gradient_background.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/card_container.dart';
import '../widgets/common/status_badge.dart';
import '../utils/todo_ui_helper.dart';
import '../widgets/common/custom_modal.dart';

class TodoDetailPage extends StatelessWidget {
  final String todoId;
  
  const TodoDetailPage({super.key, required this.todoId});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:const CustomAppBar(
        title: AppStrings.todoDetails,
        showNotification: false,
      ),
      body: GradientBackground(
        child: SafeArea(
          child: BlocConsumer<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state is TodoOperationSuccess) {
                CustomModal.show(
                  context: context,
                  position: ModalPosition.bottom,
                  size: ModalSize.small,
                  title: 'Success!',
                  message: state.message,
                  type: ModalType.success,
                  primaryButtonText: 'OK',
                );
              } else if (state is TodoError) {
                CustomModal.show(
                  context: context,
                  position: ModalPosition.bottom,
                  size: ModalSize.small,
                  title: 'Error',
                  message: state.message,
                  type: ModalType.error,
                  primaryButtonText: 'OK',
                );
              }
            },
            builder: (context, state) {
              if (state is TodoLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              } else if (state is TodosLoaded) {
                // Find the todo from the loaded list
                final todo = state.todos.firstWhere(
                  (t) => t.id == todoId,
                  orElse: () => state.todos.first,
                );
                return _buildTodoDetail(context, todo);
              } else if (state is TodoDetailLoaded) {
                return _buildTodoDetail(context, state.todo);
              }
              
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildTodoDetail(BuildContext context, todo) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Todo Card
          CardContainer(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and icon
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        todo.title,
                        style: AppTextStyles.bodyLarge,
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: TodoUiHelper.getIconBackgroundColor(todo.title),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(
                        TodoUiHelper.getIcon(todo.title),
                        size: 14,
                        color: TodoUiHelper.getIconColor(todo.title),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Description
                Text(
                  todo.description,
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 8),
                // Time and status
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.primaryLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      AppStrings.time1000AM,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                    const Spacer(),
                    StatusBadge(isCompleted: todo.isCompleted),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
