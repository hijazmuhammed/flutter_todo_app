import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../domain/entities/todo.dart';
import '../../utils/todo_ui_helper.dart';
import '../common/status_badge.dart';

class TodoItemCard extends StatefulWidget {
  final Todo todo;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;
  
  const TodoItemCard({
    super.key,
    required this.todo,
    this.onTap,
    this.onToggle,
  });

  @override
  State<TodoItemCard> createState() => _TodoItemCardState();
}

class _TodoItemCardState extends State<TodoItemCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedOpacity(
        opacity: _isPressed ? 0.6 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 32,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
                // Icon container
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: TodoUiHelper.getIconBackgroundColor(widget.todo.title),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    TodoUiHelper.getIcon(widget.todo.title),
                    size: 20,
                    color: TodoUiHelper.getIconColor(widget.todo.title),
                  ),
                ),
                const SizedBox(width: 12),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.todo.title,
                        style: AppTextStyles.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.todo.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.todo.description,
                          style: AppTextStyles.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                // Status indicator
                StatusBadge(isCompleted: widget.todo.isCompleted),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
