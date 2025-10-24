import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../widgets/common/gradient_background.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/custom_text_field.dart';
import '../widgets/common/date_picker_field.dart';
import '../widgets/common/custom_modal.dart';
import '../widgets/common/custom_button.dart';
import 'todo_list_page.dart';

class AddTodoPage extends StatefulWidget {
  final Todo? todo; // For edit mode
  
  const AddTodoPage({super.key, this.todo});
  
  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  
  // Error state
  String? _titleError;
  String? _descriptionError;
  
  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description;
    }
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: widget.todo != null ? AppStrings.editTodo : AppStrings.addTask,
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
                  primaryButtonText: 'Great',
                  onPrimaryPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: context.read<TodoBloc>(),
                          child: const TodoListPage(),
                        ),
                      ),
                      (route) => false,
                    );
                  },
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
              final isLoading = state is TodoLoading;
              return _buildForm(context, isLoading);
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildForm(BuildContext context, bool isLoading) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
       
        child:  Padding(
            padding: EdgeInsets.only(
              left: 19,
              right: 19,
              top: 19,
              bottom: MediaQuery.of(context).viewInsets.bottom + 19,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            // Project Name Field
            CustomTextField(
              label: AppStrings.projectName,
              controller: _titleController,
              enabled: !isLoading,
              hasError: _titleError != null,
            ),
            if (_titleError != null)
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 6),
                child: Text(
                  _titleError!,
                  style: const TextStyle(
                    color: AppColors.error,
                    fontSize: 12,
                    height: 1.2,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            
            // Description Field
            CustomTextField(
              label: AppStrings.todoDescription,
              controller: _descriptionController,
              maxLines: 5,
              enabled: !isLoading,
              hasError: _descriptionError != null,
            ),
            if (_descriptionError != null)
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 6),
                child: Text(
                  _descriptionError!,
                  style: const TextStyle(
                    color: AppColors.error,
                    fontSize: 12,
                    height: 1.2,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            
            // Start Date Field
            DatePickerField(
              label: AppStrings.startDate,
              selectedDate: _startDate,
              onDateSelected: (date) {
                setState(() {
                  _startDate = date;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // End Date Field
            DatePickerField(
              label: AppStrings.endDate,
              selectedDate: _endDate,
              onDateSelected: (date) {
                setState(() {
                  _endDate = date;
                });
              },
            ),
            const SizedBox(height: 32),
            
            // Add Project Button
            CustomButton(
              text: AppStrings.addProject,
              size: ButtonSize.large,
              isFullWidth: true,
              icon: Icons.add_task,
              isLoading: isLoading,
              onPressed: _saveTodo,
            ),
            
            // Extra bottom padding for keyboard
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          )
        
      
    );
  }
  
  bool _validateFields() {
    bool isValid = true;
    
    setState(() {
      // Validate title
      if (_titleController.text.isEmpty) {
        _titleError = AppStrings.titleRequired;
        isValid = false;
      } else if (_titleController.text.length < 3) {
        _titleError = 'Title must be at least 3 characters';
        isValid = false;
      } else {
        _titleError = null;
      }
      
      // Validate description
      if (_descriptionController.text.isEmpty) {
        _descriptionError = AppStrings.descriptionRequired;
        isValid = false;
      } else {
        _descriptionError = null;
      }
    });
    
    return isValid;
  }
  
  void _saveTodo() {
    if (_validateFields()) {
      if (widget.todo != null) {
        // Update existing todo
        final updatedTodo = widget.todo!.copyWith(
          title: _titleController.text,
          description: _descriptionController.text,
          updatedAt: DateTime.now(),
        );
        context.read<TodoBloc>().add(UpdateTodoEvent(todo: updatedTodo));
      } else {
        // Add new todo
        context.read<TodoBloc>().add(
          AddTodoEvent(
            title: _titleController.text,
            description: _descriptionController.text,
          ),
        );
      }
    }
  }
}