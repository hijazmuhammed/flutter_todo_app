import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../bloc/todo_bloc.dart';
import '../../bloc/todo_state.dart';
import 'profile_section.dart';
import 'notification_icon_badge.dart';
import 'count_badge.dart';

/// Header section for todo list page
/// Includes profile, notification icon, and task count
class TodoListHeader extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;
  
  const TodoListHeader({
    super.key,
    this.onProfileTap,
    this.onNotificationTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.transparent,
      child: Column(
        children: [
          // Top row with profile and notification
          Row(
            children: [
              // Profile section
              ProfileSection(
                onTap: onProfileTap,
              ),
              const Spacer(),
              // Notification icon
              NotificationIconBadge(
                onTap: onNotificationTap,
              ),
            ],
          ),
          const SizedBox(height: 25),
          // Task To do section
          Row(
            children: [
              Text(
                AppStrings.taskToDo,
                style: AppTextStyles.h2,
              ),
              const SizedBox(width: 16),
              BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  int todoCount = 0;
                  if (state is TodosLoaded) {
                    todoCount = state.todos.length;
                  }
                  return CountBadge(count: todoCount);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

