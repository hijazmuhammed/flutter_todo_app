# Widget Structure & Reusability Map

## Reusable Widgets Overview

### Widget Hierarchy
```
lib/features/presentation/widgets/
├── card_container.dart          # Elevated container with shadow
├── custom_app_bar.dart          # Standardized app bar
├── custom_back_button.dart      # Custom back navigation (existing)
├── custom_text_field.dart       # Form input field
├── date_picker_field.dart       # Date selection (existing)
├── empty_state_widget.dart      # Empty list state (existing)
├── gradient_background.dart     # App gradient background (NEW)
├── status_badge.dart            # Completion status badge (NEW)
└── todo_item_card.dart          # Todo list item (existing)
```

## Page Widget Usage

### 1. AddTodoPage
```
AddTodoPage
└── Scaffold
    ├── CustomAppBar (NEW)
    │   ├── CustomBackButton
    │   └── Notification IconButton
    └── GradientBackground (NEW)
        └── BlocConsumer<TodoBloc>
            └── Form
                ├── CustomTextField (NEW) - Title
                ├── CustomTextField (NEW) - Description
                ├── DatePickerField - Start Date
                ├── DatePickerField - End Date
                └── ElevatedButton - Submit
```

**Improvements:**
- ✅ Removed local `_isLoading` state (now uses BLoC state)
- ✅ Uses `CustomAppBar` instead of manual AppBar
- ✅ Uses `GradientBackground` instead of Container with decoration
- ✅ Uses `CustomTextField` instead of `_buildTextField()` method
- ✅ Changed from `BlocListener` to `BlocConsumer`

### 2. TodoDetailPage
```
TodoDetailPage
└── Scaffold
    ├── CustomAppBar (NEW)
    │   └── CustomBackButton
    └── GradientBackground (NEW)
        └── BlocConsumer<TodoBloc>
            └── CardContainer (NEW)
                ├── Row (Title + Icon)
                ├── Text (Description)
                └── Row (Time + StatusBadge)
                    └── StatusBadge (NEW)
```

**Improvements:**
- ✅ Uses `CustomAppBar` instead of manual AppBar
- ✅ Uses `GradientBackground` instead of Container with decoration
- ✅ Uses `CardContainer` instead of manual Container styling
- ✅ Uses `StatusBadge` instead of inline badge widget
- ✅ Uses `TodoUiHelper` for icon logic

### 3. TodoListPage
```
TodoListPage
└── PopScope
    └── Scaffold
        ├── GradientBackground (NEW)
        │   └── SafeArea
        │       ├── Header
        │       │   ├── Profile Section
        │       │   └── Notification Icon
        │       └── BlocConsumer<TodoBloc>
        │           └── ListView
        │               └── TodoItemCard
        │                   ├── Icon Container (TodoUiHelper)
        │                   ├── Todo Content
        │                   └── StatusBadge (NEW)
        └── FloatingActionButton
```

**Improvements:**
- ✅ Uses `GradientBackground` instead of Container with decoration
- ✅ TodoItemCard now uses `StatusBadge` widget

### 4. OnboardingPage
```
OnboardingPage
└── Scaffold
    └── GradientBackground (NEW)
        └── Stack
            ├── Background Decorations
            ├── SafeArea
            │   ├── Illustration Stack
            │   ├── Title Text
            │   ├── Description Text
            │   └── Start Button
            └── Decorative Elements
```

**Improvements:**
- ✅ Uses `GradientBackground` instead of Container with decoration

## Widget Reusability Matrix

| Widget | AddTodo | TodoDetail | TodoList | Onboarding | TodoItemCard |
|--------|---------|------------|----------|------------|--------------|
| GradientBackground | ✅ | ✅ | ✅ | ✅ | - |
| CustomAppBar | ✅ | ✅ | - | - | - |
| CustomBackButton | via AppBar | via AppBar | - | - | - |
| CardContainer | via TextField | ✅ | via ItemCard | - | ✅ |
| StatusBadge | - | ✅ | via ItemCard | - | ✅ |
| CustomTextField | ✅ (x2) | - | - | - | - |
| DatePickerField | ✅ (x2) | - | - | - | - |
| EmptyStateWidget | - | - | ✅ | - | - |
| TodoItemCard | - | - | ✅ | - | - |
| TodoUiHelper | - | ✅ | ✅ | - | ✅ |

## Component Dependencies

### GradientBackground
```dart
Dependencies: None
Used by: All pages
Purpose: Consistent app background
```

### CustomAppBar
```dart
Dependencies: CustomBackButton
Used by: AddTodoPage, TodoDetailPage
Purpose: Standardized navigation header
```

### CardContainer
```dart
Dependencies: AppColors
Used by: TodoDetailPage, CustomTextField, TodoItemCard
Purpose: Elevated content containers
```

### StatusBadge
```dart
Dependencies: AppColors, AppTextStyles, AppStrings
Used by: TodoDetailPage, TodoItemCard
Purpose: Completion status indication
```

### CustomTextField
```dart
Dependencies: CardContainer, AppColors, AppTextStyles
Used by: AddTodoPage
Purpose: Form inputs with validation
```

## BLoC Integration

### State Management Flow
```
User Action
    ↓
UI Widget (Page)
    ↓
BLoC Event (AddTodoEvent, UpdateTodoEvent, etc.)
    ↓
BLoC (TodoBloc) → Use Case → Repository
    ↓
BLoC State (TodoLoading, TodosLoaded, TodoError, etc.)
    ↓
UI Widget (Page) - BlocConsumer/BlocBuilder
    ↓
UI Update
```

### Separation of Concerns

**✅ Proper Separation:**
- **Pages:** Handle user interaction and layout
- **Widgets:** Reusable UI components (no business logic)
- **BLoC:** State management and business logic coordination
- **Use Cases:** Encapsulated business operations
- **UI Helpers:** UI-specific logic (icon selection, colors)

**❌ Avoided Anti-patterns:**
- ~~Local state duplicating BLoC state~~ (Fixed in AddTodoPage)
- ~~Business logic in widgets~~ (All in use cases)
- ~~Direct data access from UI~~ (All through BLoC)
- ~~Duplicate UI code~~ (Extracted to reusable widgets)

## Code Reduction Analysis

### Before Refactoring
```dart
// Each page had this repeated:
Container(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFE8E0F5),
        Color(0xFFFFF8E1),
      ],
    ),
  ),
  child: child,
)

// AppBar repeated:
AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  leading: CustomBackButton(),
  title: Text(title, style: AppTextStyles.h2),
  centerTitle: true,
  actions: [IconButton(...)],
)

// Status badge repeated:
Container(
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  decoration: BoxDecoration(
    color: AppColors.iconBgLightPurple,
    borderRadius: BorderRadius.circular(7),
  ),
  child: Text('Done', style: ...),
)
```

### After Refactoring
```dart
// Now simply:
GradientBackground(child: child)

CustomAppBar(title: title)

StatusBadge(isCompleted: isCompleted)
```

**Result:**
- 15 lines → 1 line (GradientBackground)
- 8 lines → 1 line (CustomAppBar)
- 9 lines → 1 line (StatusBadge)

## Testing Benefits

### Unit Testing
Each reusable widget can now be tested independently:

```dart
testWidgets('StatusBadge shows when completed', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: StatusBadge(isCompleted: true),
    ),
  );
  expect(find.text('Done'), findsOneWidget);
});
```

### Widget Testing
Pages are easier to test as they use composable widgets:

```dart
testWidgets('AddTodoPage renders correctly', (tester) async {
  // Mock dependencies
  // Test that CustomAppBar, GradientBackground, etc. are present
});
```

## Maintenance Advantages

### Scenario: Change Gradient Colors
**Before:** Edit 4 files (all pages)
**After:** Edit 1 file (`gradient_background.dart`)

### Scenario: Change Card Shadow
**Before:** Edit 3-4 locations across multiple files
**After:** Edit 1 file (`card_container.dart`)

### Scenario: Change Status Badge Style
**Before:** Edit 2 files (`todo_detail_page.dart`, `todo_item_card.dart`)
**After:** Edit 1 file (`status_badge.dart`)

## Conclusion

The refactoring has resulted in:
- ✅ **Better Code Organization:** Clear widget hierarchy
- ✅ **Improved Reusability:** 5 new reusable widgets
- ✅ **Easier Maintenance:** Single source of truth for common patterns
- ✅ **Better Testability:** Widgets can be tested in isolation
- ✅ **Cleaner Pages:** Pages are now more focused on their specific functionality
- ✅ **Proper Architecture:** Clean separation between UI, logic, and data layers

