# Custom Components Usage Guide

## 🎨 CustomButton

### Overview
A highly flexible button component with multiple size and style variants.

### Features
- ✅ **3 Sizes**: Small, Medium, Large
- ✅ **7 Variants**: Primary, Success, Error, Warning, Info, Secondary, Outline
- ✅ **Icons**: Optional left or right positioned icons
- ✅ **Loading State**: Built-in loading indicator
- ✅ **Full Width**: Optional full-width mode

### Basic Usage

```dart
import 'package:your_app/features/presentation/widgets/common/custom_button.dart';

// Simple primary button
CustomButton(
  text: 'Submit',
  onPressed: () => print('Pressed'),
)

// Full width large button
CustomButton(
  text: 'Continue',
  size: ButtonSize.large,
  isFullWidth: true,
  onPressed: () => submit(),
)
```

### Size Variants

```dart
// Small button (height: 36px)
CustomButton(
  text: 'Small',
  size: ButtonSize.small,
  onPressed: () {},
)

// Medium button (height: 44px) - DEFAULT
CustomButton(
  text: 'Medium',
  size: ButtonSize.medium,
  onPressed: () {},
)

// Large button (height: 52px)
CustomButton(
  text: 'Large',
  size: ButtonSize.large,
  onPressed: () {},
)
```

### Style Variants

```dart
// Primary (purple) - DEFAULT
CustomButton(
  text: 'Primary',
  variant: ButtonVariant.primary,
  onPressed: () {},
)

// Success (green)
CustomButton(
  text: 'Success',
  variant: ButtonVariant.success,
  onPressed: () {},
)

// Error (red)
CustomButton(
  text: 'Delete',
  variant: ButtonVariant.error,
  onPressed: () {},
)

// Warning (orange)
CustomButton(
  text: 'Warning',
  variant: ButtonVariant.warning,
  onPressed: () {},
)

// Info (blue)
CustomButton(
  text: 'Info',
  variant: ButtonVariant.info,
  onPressed: () {},
)

// Secondary (light purple background)
CustomButton(
  text: 'Secondary',
  variant: ButtonVariant.secondary,
  onPressed: () {},
)

// Outline (border only)
CustomButton(
  text: 'Outline',
  variant: ButtonVariant.outline,
  onPressed: () {},
)
```

### With Icons

```dart
// Icon on left (default)
CustomButton(
  text: 'Add Todo',
  icon: Icons.add,
  onPressed: () {},
)

// Icon on right
CustomButton(
  text: 'Next',
  icon: Icons.arrow_forward,
  iconRight: true,
  onPressed: () {},
)

// Large button with icon
CustomButton(
  text: 'Save Changes',
  icon: Icons.save,
  size: ButtonSize.large,
  variant: ButtonVariant.success,
  onPressed: () {},
)
```

### Loading State

```dart
CustomButton(
  text: 'Loading...',
  isLoading: true, // Shows loading spinner
  onPressed: () {}, // Disabled during loading
)

// In stateful widget
CustomButton(
  text: 'Submit',
  isLoading: _isSubmitting,
  onPressed: _submit,
)
```

### Complete Example

```dart
class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full width primary button
        CustomButton(
          text: 'Save Changes',
          size: ButtonSize.large,
          isFullWidth: true,
          icon: Icons.save,
          isLoading: _isLoading,
          onPressed: _handleSubmit,
        ),
        
        const SizedBox(height: 16),
        
        // Row of buttons
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Cancel',
                variant: ButtonVariant.outline,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                text: 'Delete',
                variant: ButtonVariant.error,
                icon: Icons.delete,
                onPressed: _handleDelete,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
```

---

## 📱 CustomModal

### Overview
A versatile modal component with multiple positions, sizes, and types.

### Features
- ✅ **2 Positions**: Bottom sheet, Center dialog
- ✅ **3 Sizes**: Small, Medium, Large
- ✅ **5 Types**: Success, Error, Warning, Info, Neutral
- ✅ **Customizable**: Buttons, content, dismissible behavior
- ✅ **Icons**: Auto-styled icons based on type

### Basic Usage

```dart
import 'package:your_app/features/presentation/widgets/common/custom_modal.dart';

// Simple center modal
CustomModal.show(
  context: context,
  title: 'Success',
  message: 'Your todo has been added successfully!',
  type: ModalType.success,
  primaryButtonText: 'OK',
  onPrimaryPressed: () => print('OK pressed'),
)

// Bottom sheet modal
CustomModal.show(
  context: context,
  position: ModalPosition.bottom,
  title: 'Delete Todo',
  message: 'Are you sure you want to delete this todo?',
  type: ModalType.error,
  primaryButtonText: 'Delete',
  secondaryButtonText: 'Cancel',
  onPrimaryPressed: () => deleteTodo(),
)
```

### Position Variants

```dart
// Center dialog (default)
CustomModal.show(
  context: context,
  position: ModalPosition.center,
  title: 'Title',
  message: 'Message',
)

// Bottom sheet
CustomModal.show(
  context: context,
  position: ModalPosition.bottom,
  title: 'Title',
  message: 'Message',
)
```

### Size Variants

```dart
// Small (300x300)
CustomModal.show(
  context: context,
  size: ModalSize.small,
  title: 'Quick Message',
  message: 'This is a small modal',
)

// Medium (400x500) - DEFAULT
CustomModal.show(
  context: context,
  size: ModalSize.medium,
  title: 'Standard Modal',
  message: 'This is a medium modal',
)

// Large (500x700)
CustomModal.show(
  context: context,
  size: ModalSize.large,
  title: 'Large Modal',
  message: 'This is a large modal with more content',
)
```

### Type Variants

```dart
// Success (green, checkmark icon)
CustomModal.show(
  context: context,
  type: ModalType.success,
  title: 'Success!',
  message: 'Operation completed successfully',
  primaryButtonText: 'Great',
)

// Error (red, error icon)
CustomModal.show(
  context: context,
  type: ModalType.error,
  title: 'Error',
  message: 'Something went wrong',
  primaryButtonText: 'Retry',
)

// Warning (orange, warning icon)
CustomModal.show(
  context: context,
  type: ModalType.warning,
  title: 'Warning',
  message: 'This action cannot be undone',
  primaryButtonText: 'Proceed',
  secondaryButtonText: 'Cancel',
)

// Info (blue, info icon)
CustomModal.show(
  context: context,
  type: ModalType.info,
  title: 'Information',
  message: 'Here are some important details',
  primaryButtonText: 'Got it',
)

// Neutral (no icon)
CustomModal.show(
  context: context,
  type: ModalType.neutral,
  title: 'Confirmation',
  message: 'Are you sure?',
  primaryButtonText: 'Yes',
  secondaryButtonText: 'No',
)
```

### With Custom Content

```dart
CustomModal.show(
  context: context,
  title: 'Select Option',
  message: 'Choose your preferred option:',
  type: ModalType.info,
  customContent: Column(
    children: [
      ListTile(
        leading: Icon(Icons.light_mode),
        title: Text('Light Mode'),
        onTap: () => setTheme('light'),
      ),
      ListTile(
        leading: Icon(Icons.dark_mode),
        title: Text('Dark Mode'),
        onTap: () => setTheme('dark'),
      ),
    ],
  ),
)
```

### Configuration Options

```dart
CustomModal.show(
  context: context,
  title: 'Custom Modal',
  message: 'This modal has custom settings',
  
  // Positioning & Size
  position: ModalPosition.center,
  size: ModalSize.medium,
  type: ModalType.success,
  
  // Buttons
  primaryButtonText: 'Confirm',
  secondaryButtonText: 'Cancel',
  onPrimaryPressed: () => print('Primary'),
  onSecondaryPressed: () => print('Secondary'),
  
  // Behavior
  isDismissible: true,  // Can dismiss by tapping outside
  showCloseButton: true, // Shows X button
  
  // Custom content
  customContent: YourWidget(),
)
```

### Real-World Examples

#### Delete Confirmation
```dart
Future<void> _showDeleteConfirmation() async {
  final result = await CustomModal.show<bool>(
    context: context,
    position: ModalPosition.bottom,
    title: 'Delete Todo',
    message: 'Are you sure you want to delete this todo? This action cannot be undone.',
    type: ModalType.error,
    size: ModalSize.small,
    primaryButtonText: 'Delete',
    secondaryButtonText: 'Cancel',
    onPrimaryPressed: () => true,
  );
  
  if (result == true) {
    _deleteTodo();
  }
}
```

#### Success Feedback
```dart
void _showSuccessModal() {
  CustomModal.show(
    context: context,
    position: ModalPosition.center,
    title: 'Todo Added!',
    message: 'Your todo has been successfully added to the list.',
    type: ModalType.success,
    size: ModalSize.small,
    primaryButtonText: 'OK',
    onPrimaryPressed: () => Navigator.pop(context),
  );
}
```

#### Error with Retry
```dart
void _showErrorModal() {
  CustomModal.show(
    context: context,
    title: 'Connection Error',
    message: 'Failed to sync your todos. Please check your internet connection.',
    type: ModalType.error,
    primaryButtonText: 'Retry',
    secondaryButtonText: 'Cancel',
    onPrimaryPressed: () => _retrySync(),
    isDismissible: false, // Force user to choose
  );
}
```

#### Information Modal
```dart
void _showInfoModal() {
  CustomModal.show(
    context: context,
    position: ModalPosition.bottom,
    size: ModalSize.medium,
    title: 'How to Use',
    message: 'Swipe left on a todo to delete it, or tap to view details.',
    type: ModalType.info,
    primaryButtonText: 'Got it',
  );
}
```

#### Custom Form Modal
```dart
void _showFormModal() {
  final controller = TextEditingController();
  
  CustomModal.show(
    context: context,
    title: 'Add Note',
    message: 'Enter your note below:',
    type: ModalType.neutral,
    customContent: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Type here...',
          border: OutlineInputBorder(),
        ),
        maxLines: 3,
      ),
    ),
    primaryButtonText: 'Save',
    secondaryButtonText: 'Cancel',
    onPrimaryPressed: () => _saveNote(controller.text),
  );
}
```

---

## 🎯 Integration Examples

### In AddTodoPage
```dart
// Replace existing button
SizedBox(
  width: double.infinity,
  height: 52,
  child: CustomButton(
    text: AppStrings.addProject,
    size: ButtonSize.large,
    isFullWidth: true,
    icon: Icons.add,
    isLoading: isLoading,
    onPressed: _saveTodo,
  ),
)
```

### In TodoListPage
```dart
// Show delete confirmation
void _showDeleteConfirmation(String todoId) {
  CustomModal.show(
    context: context,
    position: ModalPosition.bottom,
    title: 'Delete Todo',
    message: 'Are you sure you want to delete this todo?',
    type: ModalType.error,
    primaryButtonText: 'Delete',
    secondaryButtonText: 'Cancel',
    onPrimaryPressed: () {
      context.read<TodoBloc>().add(DeleteTodoEvent(id: todoId));
    },
  );
}
```

### In Error Handling
```dart
BlocListener<TodoBloc, TodoState>(
  listener: (context, state) {
    if (state is TodoError) {
      CustomModal.show(
        context: context,
        title: 'Error',
        message: state.message,
        type: ModalType.error,
        primaryButtonText: 'Retry',
        secondaryButtonText: 'Cancel',
        onPrimaryPressed: () {
          context.read<TodoBloc>().add(LoadTodosEvent());
        },
      );
    } else if (state is TodoOperationSuccess) {
      CustomModal.show(
        context: context,
        title: 'Success',
        message: state.message,
        type: ModalType.success,
        size: ModalSize.small,
        primaryButtonText: 'OK',
      );
    }
  },
  child: YourWidget(),
)
```

---

## 🎨 Customization

### Button Colors
All button variants use colors from `AppColors`:
- Primary: `AppColors.primary` (Purple)
- Success: `AppColors.success` (Green)
- Error: `AppColors.error` (Red)
- Warning: `AppColors.warning` (Orange)
- Info: `AppColors.info` (Blue)

### Modal Types & Colors
- Success: Green with checkmark ✓
- Error: Red with error icon ⚠
- Warning: Orange with warning icon ⚠️
- Info: Blue with info icon ℹ️
- Neutral: No icon, primary color

---

## 📦 Benefits

### CustomButton
✅ **Consistent**: Same styling across app  
✅ **Flexible**: 21 combinations (3 sizes × 7 variants)  
✅ **Complete**: Loading, icons, full-width support  
✅ **Accessible**: Proper disabled states  

### CustomModal
✅ **Versatile**: Bottom & center positions  
✅ **Typed**: Auto-styled by type  
✅ **Interactive**: 1-2 button support  
✅ **Customizable**: Custom content support  

Both components follow clean architecture principles and integrate seamlessly with your existing design system! 🚀

