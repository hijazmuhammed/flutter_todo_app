# Flutter Todo App - Clean Architecture Implementation Guide

## Project Overview
This is a machine test project for creating a Todo List application following Clean Architecture principles with Flutter, BLoC state management, and Supabase backend.

**Important**: Work section by section. Complete each section fully before moving to the next one. Test each section before proceeding.

---

## Requirements Summary
- **Features**: List all todos, Add new todo, View todo details
- **Architecture**: Clean Architecture (Domain, Data, Presentation layers)
- **State Management**: BLoC pattern
- **Backend**: Supabase
- **Design**: Follow Figma design exactly (link provided below)
- **Code Quality**: Clean, well-structured, production-ready code

---

## Figma Design Reference
[Paste the complete Figma design link and screenshots here]

**Design Notes to Extract from Figma**:
- Color palette (primary, secondary, background, text colors)
- Typography (font families, sizes, weights)
- Spacing and padding values
- Button styles and sizes
- Card/container styles
- Icon styles
- Animation/transition requirements

---

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── app_text_styles.dart
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   │   └── supabase_client.dart
│   ├── usecases/
│   │   └── usecase.dart
│   └── utils/
│       └── date_formatter.dart
│
├── features/
│   └── todo/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── todo_remote_data_source.dart
│       │   ├── models/
│       │   │   └── todo_model.dart
│       │   └── repositories/
│       │       └── todo_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── todo.dart
│       │   ├── repositories/
│       │   │   └── todo_repository.dart
│       │   └── usecases/
│       │       ├── add_todo.dart
│       │       ├── get_todo_detail.dart
│       │       ├── get_todos.dart
│       │       ├── update_todo.dart
│       │       ├── delete_todo.dart
│       │       └── toggle_todo_status.dart
│       │
│       └── presentation/
│           ├── bloc/
│           │   ├── todo_bloc.dart
│           │   ├── todo_event.dart
│           │   └── todo_state.dart
│           ├── pages/
│           │   ├── todo_list_page.dart
│           │   ├── add_todo_page.dart
│           │   └── todo_detail_page.dart
│           └── widgets/
│               ├── todo_item_card.dart
│               ├── custom_text_field.dart
│               └── empty_state_widget.dart
│
├── injection_container.dart
└── main.dart
```

---

## SECTION 1: Initial Setup & Dependencies

### Step 1.1: Create Flutter Project
```bash
flutter create todo_app
cd todo_app
```

### Step 1.2: Update pubspec.yaml
Add these dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  
  # Supabase Backend
  supabase_flutter: ^2.0.0
  
  # Dependency Injection
  get_it: ^7.6.4
  
  # Functional Programming
  dartz: ^0.10.1
  
  # UI
  google_fonts: ^6.1.0
  intl: ^0.18.1
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  mockito: ^5.4.2
  bloc_test: ^9.1.5
```

Run: `flutter pub get`

### Step 1.3: Create Folder Structure
Create all the folders as shown in the project structure above.

**Testing**: Verify all folders are created correctly.

---

## SECTION 2: Core Layer Setup

### Step 2.1: Create Error Handling

**File**: `lib/core/error/failures.dart`
- Create base `Failure` class extending `Equatable`
- Create specific failures: `ServerFailure`, `CacheFailure`, `NetworkFailure`, `ValidationFailure`
- Each failure should have a `message` property

**File**: `lib/core/error/exceptions.dart`
- Create `ServerException`, `CacheException`, `NetworkException`
- Each exception should have a `message` property

### Step 2.2: Create Base UseCase

**File**: `lib/core/usecases/usecase.dart`
- Create abstract `UseCase<Type, Params>` class
- Define `call` method returning `Future<Either<Failure, Type>>`
- Create `NoParams` class for use cases without parameters

### Step 2.3: Extract Design System from Figma

**File**: `lib/core/constants/app_colors.dart`
- Extract ALL colors from Figma design
- Define as static constants (primary, secondary, background, text colors, etc.)
- Include status colors for todo states

**File**: `lib/core/constants/app_text_styles.dart`
- Extract typography from Figma (font family, sizes, weights)
- Use `google_fonts` package
- Create styles for: headings, body text, buttons, captions

**File**: `lib/core/constants/app_strings.dart`
- Define all static strings used in the app
- Include: screen titles, button labels, error messages, validation messages

### Step 2.4: Supabase Configuration

**File**: `lib/core/network/supabase_client.dart`
- Create `SupabaseConfig` class
- Add placeholder constants for URL and anon key
- Create `initialize()` method
- Create getter for `client`

### Step 2.5: Utilities

**File**: `lib/core/utils/date_formatter.dart`
- Create helper functions for date formatting
- Example: `formatDate(DateTime date)`, `timeAgo(DateTime date)`

**Testing**: 
- Verify all core files compile without errors
- Test date formatter functions

---

## SECTION 3: Domain Layer (Business Logic)

### Step 3.1: Create Todo Entity

**File**: `lib/features/todo/domain/entities/todo.dart`
- Pure Dart class extending `Equatable`
- Properties: `id`, `title`, `description`, `isCompleted`, `createdAt`, `updatedAt`
- Implement `copyWith` method
- Override `props` for Equatable

**Important**: Entity should have NO dependencies on Flutter or external packages (except Equatable)

### Step 3.2: Create Repository Interface

**File**: `lib/features/todo/domain/repositories/todo_repository.dart`
- Define abstract class `TodoRepository`
- Define methods (all return `Either<Failure, T>`):
  - `getTodos()` → `Future<Either<Failure, List<Todo>>>`
  - `getTodoById(String id)` → `Future<Either<Failure, Todo>>`
  - `addTodo({title, description})` → `Future<Either<Failure, Todo>>`
  - `updateTodo(Todo todo)` → `Future<Either<Failure, Todo>>`
  - `deleteTodo(String id)` → `Future<Either<Failure, void>>`
  - `toggleTodoStatus(String id)` → `Future<Either<Failure, Todo>>`

### Step 3.3: Create Use Cases

Create these use cases one by one. Each use case should:
- Implement `UseCase<ReturnType, Params>`
- Take repository as constructor parameter
- Implement `call` method
- Define params class if needed (extending Equatable)

**Files to create**:
1. `lib/features/todo/domain/usecases/get_todos.dart`
   - Params: `NoParams`
   - Returns: `List<Todo>`

2. `lib/features/todo/domain/usecases/get_todo_detail.dart`
   - Params: `GetTodoDetailParams(id)`
   - Returns: `Todo`

3. `lib/features/todo/domain/usecases/add_todo.dart`
   - Params: `AddTodoParams(title, description)`
   - Returns: `Todo`

4. `lib/features/todo/domain/usecases/update_todo.dart`
   - Params: `UpdateTodoParams(todo)`
   - Returns: `Todo`

5. `lib/features/todo/domain/usecases/delete_todo.dart`
   - Params: `DeleteTodoParams(id)`
   - Returns: `void`

6. `lib/features/todo/domain/usecases/toggle_todo_status.dart`
   - Params: `ToggleTodoStatusParams(id)`
   - Returns: `Todo`

**Testing**: 
- Verify all domain layer files compile
- Domain layer should have NO Flutter/UI dependencies

---

## SECTION 4: Data Layer

### Step 4.1: Create Todo Model

**File**: `lib/features/todo/data/models/todo_model.dart`
- Extend `Todo` entity
- Implement `fromJson` factory constructor
- Implement `toJson` method
- Implement `fromEntity` factory constructor
- Implement `toEntity` method
- Map Supabase field names (e.g., `is_completed` → `isCompleted`)

**Field Mapping**:
```
Supabase DB     →  Model/Entity
id              →  id
title           →  title
description     →  description
is_completed    →  isCompleted
created_at      →  createdAt
updated_at      →  updatedAt
```

### Step 4.2: Create Remote Data Source

**File**: `lib/features/todo/data/datasources/todo_remote_data_source.dart`

Create abstract class and implementation:

**Abstract class**: `TodoRemoteDataSource`
- Define methods (all return `Future<T>` or throw exceptions)

**Implementation**: `TodoRemoteDataSourceImpl`
- Take `SupabaseClient` as constructor parameter
- Implement all methods using Supabase queries
- Handle errors and throw appropriate exceptions

Methods to implement:
1. `getTodos()` 
   - Query: `select().order('created_at', ascending: false)`
   - Return: `List<TodoModel>`

2. `getTodoById(String id)`
   - Query: `select().eq('id', id).single()`
   - Return: `TodoModel`

3. `addTodo({title, description})`
   - Query: `insert({...}).select().single()`
   - Return: `TodoModel`

4. `updateTodo(TodoModel todo)`
   - Query: `update({...}).eq('id', id).select().single()`
   - Return: `TodoModel`

5. `deleteTodo(String id)`
   - Query: `delete().eq('id', id)`
   - Return: `void`

6. `toggleTodoStatus(String id)`
   - First fetch todo, then update with toggled status
   - Return: `TodoModel`

**Error Handling**: Wrap all queries in try-catch, convert to appropriate exceptions

### Step 4.3: Create Repository Implementation

**File**: `lib/features/todo/data/repositories/todo_repository_impl.dart`
- Implement `TodoRepository` interface
- Take `TodoRemoteDataSource` as constructor parameter
- Implement all repository methods
- Convert exceptions to failures using try-catch
- Convert models to entities before returning

Pattern for each method:
```dart
try {
  final result = await remoteDataSource.someMethod();
  return Right(result.toEntity());
} on ServerException catch (e) {
  return Left(ServerFailure(e.message));
} catch (e) {
  return Left(ServerFailure(e.toString()));
}
```

**Testing**: 
- Verify data layer compiles
- Repository properly converts models to entities

---

## SECTION 5: Presentation Layer - BLoC

### Step 5.1: Define Todo Events

**File**: `lib/features/todo/presentation/bloc/todo_event.dart`
- Create abstract `TodoEvent` extending `Equatable`
- Create specific events:
  - `LoadTodosEvent`
  - `AddTodoEvent(title, description)`
  - `UpdateTodoEvent(todo)`
  - `DeleteTodoEvent(id)`
  - `ToggleTodoStatusEvent(id)`
  - `LoadTodoDetailEvent(id)`

### Step 5.2: Define Todo States

**File**: `lib/features/todo/presentation/bloc/todo_state.dart`
- Create abstract `TodoState` extending `Equatable`
- Create specific states:
  - `TodoInitial`
  - `TodoLoading`
  - `TodosLoaded(List<Todo> todos)`
  - `TodoDetailLoaded(Todo todo)`
  - `TodoOperationSuccess(String message)`
  - `TodoError(String message)`

### Step 5.3: Implement Todo BLoC

**File**: `lib/features/todo/presentation/bloc/todo_bloc.dart`
- Extend `Bloc<TodoEvent, TodoState>`
- Inject all use cases via constructor
- Implement event handlers using `on<EventType>`
- Handle loading states properly
- Convert failures to error messages

Event handlers to implement:
1. `_onLoadTodos` → calls `GetTodos` use case
2. `_onAddTodo` → calls `AddTodo` use case
3. `_onUpdateTodo` → calls `UpdateTodo` use case
4. `_onDeleteTodo` → calls `DeleteTodo` use case
5. `_onToggleTodoStatus` → calls `ToggleTodoStatus` use case
6. `_onLoadTodoDetail` → calls `GetTodoDetail` use case

**Error Handling**: Convert `Either` results properly:
```dart
result.fold(
  (failure) => emit(TodoError(failure.message)),
  (data) => emit(SuccessState(data)),
);
```

**Testing**: Verify BLoC compiles and events are registered

---

## SECTION 6: Dependency Injection

**File**: `lib/injection_container.dart`

Set up GetIt service locator:

```dart
final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => TodoBloc(...));
  
  // Use Cases
  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  // ... register all use cases
  
  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(remoteDataSource: sl()),
  );
  
  // Data Sources
  sl.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(client: sl()),
  );
  
  // External
  sl.registerLazySingleton(() => SupabaseConfig.client);
}
```

**Testing**: Verify dependency injection setup compiles

---

## SECTION 7: Presentation Layer - UI (Todo List Screen)

**IMPORTANT**: Follow Figma design EXACTLY. Pay attention to:
- Spacing, padding, margins
- Colors, fonts, sizes
- Border radius, shadows
- Icon styles and positions
- Button styles
- Card layouts

4 Screens 
Screen 1 :
lib\core\assets\image1.png

/* let's start */

position: relative;
width: 375px;
height: 812px;

background: #FFFFFF;


/* Ellipse 1 */

position: absolute;
width: 60px;
height: 60px;
left: 333px;
top: 232px;

background: linear-gradient(180deg, #2555FF 0%, rgba(37, 85, 255, 0.25) 100%);
filter: blur(50px);


/* Ellipse 3 */

position: absolute;
width: 58px;
height: 58px;
left: 76px;
top: 424px;

background: linear-gradient(180deg, #46BDF0 0%, rgba(70, 179, 240, 0.15) 100%);
filter: blur(50px);


/* Ellipse 11 */

position: absolute;
width: 58px;
height: 58px;
left: 240px;
top: 767px;

background: linear-gradient(180deg, #F0B646 0%, rgba(240, 203, 70, 0.15) 100%);
filter: blur(50px);


/* Ellipse 2 */

position: absolute;
width: 70px;
height: 70px;
left: -15px;
top: 126px;

background: linear-gradient(180deg, #46F080 0%, rgba(70, 240, 138, 0.15) 100%);
filter: blur(50px);


/* Ellipse 4 */

position: absolute;
width: 70px;
height: 70px;
left: 263px;
top: 0px;

background: linear-gradient(180deg, #EDF046 0%, rgba(240, 233, 70, 0.15) 100%);
filter: blur(50px);


/* Ellipse 17 */

position: absolute;
width: 310px;
height: 7px;
left: 34px;
top: 734px;

/* Color/Primary */
background: #5F33E1;
filter: blur(15px);


/* Rectangle 1 */

position: absolute;
width: 331px;
height: 52px;
left: 22px;
top: 687px;

/* Color/Primary */
background: #5F33E1;
border-radius: 14px;


/* Task Management & To-Do List */

position: absolute;
width: 247px;
height: 60px;
left: 64px;
top: 513px;

/* Lexend Deca/Semi Bold/24px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 600;
font-size: 24px;
line-height: 30px;
text-align: center;

/* Color/Black */
color: #24252C;



/* Let’s Start */

position: absolute;
width: 98px;
height: 24px;
left: 138px;
top: 701px;

/* Lexend Deca/Semi Bold/19px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 600;
font-size: 19px;
line-height: 24px;
/* identical to box height */
text-align: center;

color: #FFFFFF;



/* This productive tool is designed to help you better manage your task project-wise conveniently! */

position: absolute;
width: 266px;
height: 54px;
left: 54px;
top: 593px;

/* Lexend Deca/Regular/14px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 14px;
line-height: 18px;
text-align: center;

/* Color/Secondery */
color: #6E6A7C;



/* female sitting on the floor with cup in hand and laptop on leg */

position: absolute;
width: 159px;
height: 184px;
left: 131px;
top: 147px;

background: url(.png);


/* vase with tulips, glasses and pencil */

position: absolute;
width: 36px;
height: 52px;
left: 79px;
top: 279px;

background: url();


/* Blue stopwatch with pink arrow */

position: absolute;
width: 40px;
height: 50px;
left: 104px;
top: 69px;

background: url();


/* multicolored smartphone notifications */

position: absolute;
width: 62px;
height: 42px;
left: 245px;
top: 225px;

background: url(.png);
transform: matrix(-1, 0, 0, 1, 0, 0);


/* pie chart */

position: absolute;
width: 26px;
height: 26px;
left: 84px;
top: 180px;

background: url();


/* close up of pink coffee cup */

position: absolute;
width: 18px;
height: 22px;
left: 67px;
top: 310px;

background: url();
transform: matrix(-1, 0, 0, 1, 0, 0);


/* Blue desk calendar */

position: absolute;
width: 31.35px;
height: 26.6px;
left: 276px;
top: 136px;

background: url();
transform: rotate(12.86deg);


/* Ellipse 5 */

position: absolute;
width: 8px;
height: 8px;
left: 250px;
top: 383px;

background: #EAED2A;


/* Ellipse 9 */

position: absolute;
width: 8px;
height: 8px;
left: 138px;
top: 391px;

background: #FFD7E4;


/* Ellipse 7 */

position: absolute;
width: 8px;
height: 8px;
left: 252px;
top: 73px;

background: #92DEFF;


/* Ellipse 8 */

position: absolute;
width: 4px;
height: 4px;
left: 202px;
top: 92px;

background: #BE9FFF;


/* Ellipse 6 */

position: absolute;
width: 4px;
height: 4px;
left: 281px;
top: 362px;

background: #7FFCAA;


/* Ellipse 10 */

position: absolute;
width: 4px;
height: 4px;
left: 176px;
top: 405px;

background: #A4E7F9;


/* Iconly/Bold/Arrow - Left */

position: absolute;
width: 24px;
height: 24px;
left: 307px;
top: 701px;

transform: rotate(-180deg);


/* Iconly/Bold/Arrow - Left */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;

transform: rotate(-180deg);


/* Arrow - Left */

position: absolute;
width: 18px;
height: 12px;
left: 3px;
top: 6px;

transform: rotate(-180deg);


/* Arrow - Left */

position: absolute;
left: 12.5%;
right: 12.5%;
top: 25%;
bottom: 25%;

background: #FFFFFF;
transform: rotate(-180deg);


/* Path */

position: absolute;
left: 45.15%;
right: 12.5%;
top: 25%;
bottom: 25%;

background: #130F26;
transform: rotate(-180deg);


/* Path */

position: absolute;
left: 12.5%;
right: 60.91%;
top: 43.67%;
bottom: 43.68%;

background: #130F26;
transform: rotate(-180deg);

Screen2:
lib\core\assets\image2.png
/* home */

position: relative;
width: 375px;
height: 812px;

background: #FFFFFF;


/* Group 1 */

position: absolute;
width: 451px;
height: 839px;
left: -29px;
top: -14px;

opacity: 0.8;


/* Ellipse 1 */

position: absolute;
width: 60px;
height: 60px;
left: 333px;
top: 232px;

background: linear-gradient(180deg, #7C46F0 0%, rgba(124, 70, 240, 0.15) 100%);
filter: blur(75px);


/* Ellipse 3 */

position: absolute;
width: 96px;
height: 96px;
left: -29px;
top: 540px;

background: linear-gradient(180deg, #46BDF0 0%, rgba(70, 179, 240, 0.15) 100%);
filter: blur(75px);


/* Ellipse 12 */

position: absolute;
width: 74px;
height: 74px;
left: 72px;
top: 210px;

background: linear-gradient(180deg, #5F27FF 0%, #CAB8FF 100%);
filter: blur(75px);


/* Ellipse 11 */

position: absolute;
width: 58px;
height: 58px;
left: 240px;
top: 767px;

background: linear-gradient(180deg, #F0B646 0%, rgba(240, 203, 70, 0.15) 100%);
filter: blur(65px);


/* Ellipse 2 */

position: absolute;
width: 70px;
height: 70px;
left: -16px;
top: -14px;

background: linear-gradient(180deg, #46F080 0%, rgba(70, 240, 138, 0.15) 100%);
filter: blur(75px);


/* Ellipse 4 */

position: absolute;
width: 118px;
height: 118px;
left: 304px;
top: 331px;

background: linear-gradient(180deg, #EDF046 0%, rgba(240, 233, 70, 0.15) 100%);
filter: blur(75px);


/* Ellipse 15 */

position: absolute;
width: 46px;
height: 46px;
left: 22px;
top: 28px;

background: url(.jpg), #D9D9D9;


/* Group 3 */

position: absolute;
width: 131px;
height: 46px;
left: 84px;
top: 28px;



/* Hello! */

position: absolute;
width: 38px;
height: 18px;
left: 84px;
top: 28px;

/* Lexend Deca/Regular/14px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 14px;
line-height: 18px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* Livia Vaccaro */

position: absolute;
width: 131px;
height: 24px;
left: 84px;
top: 50px;

/* Lexend Deca/Semi Bold/19px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 600;
font-size: 19px;
line-height: 24px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* vuesax/bold/notification */

position: absolute;
width: 24px;
height: 24px;
left: 329px;
top: 39px;



/* vuesax/bold/notification */

position: absolute;
width: 24px;
height: 24px;
left: 0px;
top: 0px;



/* notification */

position: absolute;
width: 24px;
height: 24px;
left: 0px;
top: 0px;



/* Vector */

position: absolute;
left: 17.96%;
right: 17.94%;
top: 8.33%;
bottom: 20.83%;

/* Color/Black */
background: #24252C;


/* Vector */

position: absolute;
left: 38.25%;
right: 38.21%;
top: 83.33%;
bottom: 8.33%;

/* Color/Black */
background: #24252C;


/* Vector */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;

opacity: 0;
transform: rotate(-180deg);


/* Ellipse 28 */

position: absolute;
width: 8px;
height: 8px;
left: 13px;
top: 0px;

/* Color/Primary */
background: #5F33E1;


/* Task To do */

position: absolute;
width: 108px;
height: 24px;
left: 15px;
top: 108px;

/* Lexend Deca/Semi Bold/19px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 600;
font-size: 19px;
line-height: 24px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* Ellipse 19 */

position: absolute;
width: 16px;
height: 16px;
left: 139px;
top: 113px;

background: #EEE9FF;


/* 4 */

position: absolute;
width: 7px;
height: 14px;
left: 144px;
top: 114px;

/* Lexend Deca/Regular/11px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 11px;
line-height: 14px;
/* identical to box height */

/* Color/Primary */
color: #5F33E1;



/* Rectangle 1044 */

position: absolute;
width: 331px;
height: 66px;
left: 15px;
top: 148px;

background: #FFFFFF;
box-shadow: 0px 4px 32px rgba(0, 0, 0, 0.04);
border-radius: 15px;


/* Rectangle 1048 */

position: absolute;
width: 331px;
height: 66px;
left: 15px;
top: 230px;

background: #FFFFFF;
box-shadow: 0px 4px 32px rgba(0, 0, 0, 0.04);
border-radius: 15px;


/* Rectangle 1049 */

position: absolute;
width: 331px;
height: 66px;
left: 15px;
top: 312px;

background: #FFFFFF;
box-shadow: 0px 4px 32px rgba(0, 0, 0, 0.04);
border-radius: 15px;


/* Rectangle 1051 */

position: absolute;
width: 331px;
height: 66px;
left: 15px;
top: 394px;

background: #FFFFFF;
box-shadow: 0px 4px 32px rgba(0, 0, 0, 0.04);
border-radius: 15px;


/* Office Project */

position: absolute;
width: 94px;
height: 18px;
left: 77px;
top: 164px;

/* Lexend Deca/Regular/14px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 14px;
line-height: 18px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* Personal Project */

position: absolute;
width: 111px;
height: 18px;
left: 77px;
top: 246px;

/* Lexend Deca/Regular/14px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 14px;
line-height: 18px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* Daily Study */

position: absolute;
width: 79px;
height: 18px;
left: 77px;
top: 328px;

/* Lexend Deca/Regular/14px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 14px;
line-height: 18px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* Daily Study */

position: absolute;
width: 79px;
height: 18px;
left: 77px;
top: 410px;

/* Lexend Deca/Regular/14px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 14px;
line-height: 18px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* Rectangle 1047 */

position: absolute;
width: 34px;
height: 34px;
left: 31px;
top: 164px;

background: #FFE4F2;
border-radius: 9px;


/* vuesax/bold/briefcase */

position: absolute;
width: 20px;
height: 20px;
left: 38px;
top: 171px;



/* vuesax/bold/briefcase */

position: absolute;
width: 20px;
height: 20px;
left: 0px;
top: 0px;



/* Vector */

position: absolute;
left: 8.35%;
right: 8.34%;
top: 7.38%;
bottom: 31.04%;

background: #F478B8;


/* Vector */

position: absolute;
left: 9.75%;
right: 9.67%;
top: 55.6%;
bottom: 7.37%;

background: #F478B8;


/* Vector */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;

opacity: 0;
transform: rotate(-180deg);


/* Rectangle 1048 */

position: absolute;
width: 34px;
height: 34px;
left: 31px;
top: 246px;

background: #EDE4FF;
border-radius: 9px;


/* Rectangle 1050 */

position: absolute;
width: 34px;
height: 34px;
left: 31px;
top: 328px;

background: #FFE6D5;
border-radius: 9px;


/* Rectangle 1052 */

position: absolute;
width: 34px;
height: 34px;
left: 31px;
top: 410px;

background: #FFF6D5;
border-radius: 9px;


/* vuesax/bold/user-octagon */

position: absolute;
width: 20px;
height: 20px;
left: 38px;
top: 253px;



/* vuesax/bold/user-octagon */

position: absolute;
width: 20px;
height: 20px;
left: 0px;
top: 0px;



/* user-octagon */

position: absolute;
width: 20px;
height: 20px;
left: 0px;
top: 0px;



/* Vector */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;

opacity: 0;


/* Vector */

position: absolute;
left: 12.17%;
right: 12.13%;
top: 8.33%;
bottom: 8.33%;

background: #9260F4;


/* vuesax/bold/book */

position: absolute;
width: 20px;
height: 20px;
left: 38px;
top: 335px;



/* vuesax/bold/book */

position: absolute;
width: 20px;
height: 20px;
left: 0px;
top: 0px;



/* Vector */

position: absolute;
left: 53.12%;
right: 8.33%;
top: 11.17%;
bottom: 14.52%;

background: #FF9142;


/* Vector */

position: absolute;
left: 8.29%;
right: 53.17%;
top: 11.17%;
bottom: 14.52%;

background: #FF9142;


/* Vector */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;

opacity: 0;
transform: rotate(-180deg);


/* vuesax/bold/book */

position: absolute;
width: 20px;
height: 20px;
left: 38px;
top: 417px;



/* vuesax/bold/book */

position: absolute;
width: 20px;
height: 20px;
left: 0px;
top: 0px;



/* Vector */

position: absolute;
left: 53.12%;
right: 8.33%;
top: 11.17%;
bottom: 14.52%;

background: #FFD12E;


/* Vector */

position: absolute;
left: 8.29%;
right: 53.17%;
top: 11.17%;
bottom: 14.52%;

background: #FFD12E;


/* Vector */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;

opacity: 0;
transform: rotate(-180deg);


/* Group 4 */

position: absolute;
width: 311px;
height: 62px;
left: 171px;
top: 736px;



/* Ellipse 12 */

position: absolute;
width: 44px;
height: 44px;
left: 305px;
top: 736px;

/* Color/Primary */
background: #5F33E1;
box-shadow: 2px 10px 18px rgba(95, 51, 225, 0.49);


/* vuesax/bold/home */

position: absolute;
width: 24px;
height: 24px;
left: 171px;
top: 774px;



/* vuesax/linear/add */

position: absolute;
width: 28px;
height: 28px;
left: 313px;
top: 744px;



/* vuesax/linear/add */

position: absolute;
width: 28px;
height: 28px;
left: 0px;
top: 0px;



/* add */

position: absolute;
width: 28px;
height: 28px;
left: 0px;
top: 0px;



/* Vector */

position: absolute;
left: 25%;
right: 25%;
top: 50%;
bottom: 50%;

border: 2px solid #FFFFFF;


/* Vector */

position: absolute;
left: 50%;
right: 50%;
top: 25%;
bottom: 25%;

border: 2px solid #FFFFFF;


/* Vector */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;

opacity: 0;


/* vuesax/bulk/calendar */

position: absolute;
width: 24px;
height: 24px;
left: 238px;
top: 774px;



/* vuesax/bulk/document-text */

position: absolute;
width: 24px;
height: 24px;
left: 392px;
top: 774px;



/* vuesax/bulk/profile-2user */

position: absolute;
width: 24px;
height: 24px;
left: 458px;
top: 774px;

Screen3:
lib\core\assets\image3.png
/* today's tasks */

position: relative;
width: 375px;
height: 812px;

background: #FFFFFF;


/* Group 1 */

position: absolute;
width: 451px;
height: 839px;
left: -29px;
top: -14px;

opacity: 0.8;


/* Ellipse 1 */

position: absolute;
width: 60px;
height: 60px;
left: 333px;
top: 232px;

background: linear-gradient(180deg, #7C46F0 0%, rgba(124, 70, 240, 0.15) 100%);
filter: blur(75px);


/* Ellipse 3 */

position: absolute;
width: 96px;
height: 96px;
left: -29px;
top: 540px;

background: linear-gradient(180deg, #46BDF0 0%, rgba(70, 179, 240, 0.15) 100%);
filter: blur(75px);


/* Ellipse 12 */

position: absolute;
width: 74px;
height: 74px;
left: 72px;
top: 210px;

background: linear-gradient(180deg, #5F27FF 0%, #CAB8FF 100%);
filter: blur(75px);


/* Ellipse 11 */

position: absolute;
width: 58px;
height: 58px;
left: 240px;
top: 767px;

background: linear-gradient(180deg, #F0B646 0%, rgba(240, 203, 70, 0.15) 100%);
filter: blur(65px);


/* Ellipse 2 */

position: absolute;
width: 70px;
height: 70px;
left: -16px;
top: -14px;

background: linear-gradient(180deg, #46F080 0%, rgba(70, 240, 138, 0.15) 100%);
filter: blur(75px);


/* Ellipse 4 */

position: absolute;
width: 118px;
height: 118px;
left: 304px;
top: 331px;

background: linear-gradient(180deg, #EDF046 0%, rgba(240, 233, 70, 0.15) 100%);
filter: blur(75px);


/* Iconly/Bold/Arrow - Left */

position: absolute;
width: 24px;
height: 24px;
left: 22px;
top: 28px;



/* Iconly/Bold/Arrow - Left */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;



/* Arrow - Left */

position: absolute;
width: 18px;
height: 12px;
left: 3px;
top: 6px;



/* Arrow - Left */

position: absolute;
left: 12.5%;
right: 12.5%;
top: 25%;
bottom: 25%;

/* Color/Black */
background: #24252C;


/* Path */

position: absolute;
left: 12.5%;
right: 45.15%;
top: 25%;
bottom: 25%;

background: #130F26;


/* Path */

position: absolute;
left: 60.91%;
right: 12.5%;
top: 43.68%;
bottom: 43.67%;

background: #130F26;


/* Todo Detaills */

position: absolute;
width: 124px;
height: 24px;
left: 122px;
top: 28px;

/* Lexend Deca/Semi Bold/19px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 600;
font-size: 19px;
line-height: 24px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* Rectangle 1044 */

position: absolute;
width: 331px;
height: 94px;
left: 22px;
top: 74px;

background: #FFFFFF;
box-shadow: 0px 4px 32px rgba(0, 0, 0, 0.04);
border-radius: 15px;


/* Office Project */

position: absolute;
width: 94px;
height: 18px;
left: 38px;
top: 90px;

/* Lexend Deca/Regular/14px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 14px;
line-height: 18px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* Has to do some optimisation */

position: absolute;
width: 154px;
height: 14px;
left: 39px;
top: 114px;

/* Lexend Deca/Regular/11px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 11px;
line-height: 14px;
/* identical to box height */

/* Color/Secondery */
color: #6E6A7C;



/* 10:00 AM */

position: absolute;
width: 49px;
height: 14px;
left: 58px;
top: 138px;

/* Lexend Deca/Regular/11px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 11px;
line-height: 14px;
/* identical to box height */

color: #AB94FF;



/* Rectangle 1053 */

position: absolute;
width: 24px;
height: 24px;
left: 317px;
top: 86px;

background: #FFE4F2;
border-radius: 7px;


/* vuesax/bold/briefcase */

position: absolute;
width: 14px;
height: 14px;
left: 322px;
top: 91px;



/* vuesax/bold/briefcase */

position: absolute;
width: 14px;
height: 14px;
left: 0px;
top: 0px;



/* Vector */

position: absolute;
left: 8.35%;
right: 8.34%;
top: 7.38%;
bottom: 31.04%;

background: #F478B8;


/* Vector */

position: absolute;
left: 9.75%;
right: 9.67%;
top: 55.6%;
bottom: 7.38%;

background: #F478B8;


/* Vector */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;

opacity: 0;
transform: rotate(-180deg);


/* Iconly/Bold/Time Circle */

position: absolute;
left: 10.13%;
right: 86.13%;
top: 17%;
bottom: 81.28%;



/* Time Circle */

position: absolute;
width: 11.67px;
height: 11.67px;
left: 1.17px;
top: 1.17px;



/* Time Circle */

position: absolute;
left: 8.33%;
right: 8.33%;
top: 8.33%;
bottom: 8.33%;

background: #AB94FF;


/* Path */

position: absolute;
left: 45.42%;
right: 31.98%;
top: 28.88%;
bottom: 34.08%;



/* Path */

position: absolute;
left: 8.33%;
right: 8.33%;
top: 8.33%;
bottom: 8.33%;



/* Rectangle 1062 */

position: absolute;
width: 35px;
height: 14px;
left: 306px;
top: 138px;

background: #EDE8FF;
border-radius: 7px;


/* Done */

position: absolute;
width: 23px;
height: 11px;
left: 312px;
top: 139px;

font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 9px;
line-height: 11px;

/* Color/Primary */
color: #5F33E1;

Screen4:
lib\core\assets\image4.png
/* add project in task list */

position: relative;
width: 375px;
height: 812px;

background: #FFFFFF;


/* Group 1 */

position: absolute;
width: 451px;
height: 839px;
left: -29px;
top: -14px;

opacity: 0.8;


/* Ellipse 1 */

position: absolute;
width: 60px;
height: 60px;
left: 333px;
top: 232px;

background: linear-gradient(180deg, #7C46F0 0%, rgba(124, 70, 240, 0.15) 100%);
filter: blur(75px);


/* Ellipse 3 */

position: absolute;
width: 96px;
height: 96px;
left: -29px;
top: 540px;

background: linear-gradient(180deg, #46BDF0 0%, rgba(70, 179, 240, 0.15) 100%);
filter: blur(75px);


/* Ellipse 12 */

position: absolute;
width: 74px;
height: 74px;
left: 72px;
top: 210px;

background: linear-gradient(180deg, #5F27FF 0%, #CAB8FF 100%);
filter: blur(75px);


/* Ellipse 11 */

position: absolute;
width: 58px;
height: 58px;
left: 240px;
top: 767px;

background: linear-gradient(180deg, #F0B646 0%, rgba(240, 203, 70, 0.15) 100%);
filter: blur(65px);


/* Ellipse 2 */

position: absolute;
width: 70px;
height: 70px;
left: -16px;
top: -14px;

background: linear-gradient(180deg, #46F080 0%, rgba(70, 240, 138, 0.15) 100%);
filter: blur(75px);


/* Ellipse 4 */

position: absolute;
width: 118px;
height: 118px;
left: 304px;
top: 331px;

background: linear-gradient(180deg, #EDF046 0%, rgba(240, 233, 70, 0.15) 100%);
filter: blur(75px);


/* Iconly/Bold/Arrow - Left */

position: absolute;
width: 24px;
height: 24px;
left: 22px;
top: 28px;



/* Iconly/Bold/Arrow - Left */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;



/* Arrow - Left */

position: absolute;
width: 18px;
height: 12px;
left: 3px;
top: 6px;



/* Arrow - Left */

position: absolute;
left: 12.5%;
right: 12.5%;
top: 25%;
bottom: 25%;

/* Color/Black */
background: #24252C;


/* Path */

position: absolute;
left: 12.5%;
right: 45.15%;
top: 25%;
bottom: 25%;

background: #130F26;


/* Path */

position: absolute;
left: 60.91%;
right: 12.5%;
top: 43.68%;
bottom: 43.67%;

background: #130F26;


/* Add task */

position: absolute;
width: 84px;
height: 24px;
left: 132px;
top: 28px;

/* Lexend Deca/Semi Bold/19px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 600;
font-size: 19px;
line-height: 24px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* vuesax/bold/notification */

position: absolute;
width: 24px;
height: 24px;
left: 329px;
top: 28px;



/* vuesax/bold/notification */

position: absolute;
width: 24px;
height: 24px;
left: 0px;
top: 0px;



/* notification */

position: absolute;
width: 24px;
height: 24px;
left: 0px;
top: 0px;



/* Vector */

position: absolute;
left: 17.96%;
right: 17.94%;
top: 8.33%;
bottom: 20.83%;

/* Color/Black */
background: #24252C;


/* Vector */

position: absolute;
left: 38.25%;
right: 38.21%;
top: 83.33%;
bottom: 8.33%;

/* Color/Black */
background: #24252C;


/* Vector */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;

opacity: 0;
transform: rotate(-180deg);


/* Ellipse 28 */

position: absolute;
width: 8px;
height: 8px;
left: 13px;
top: 0px;

/* Color/Primary */
background: #5F33E1;


/* Rectangle 1073 */

position: absolute;
width: 331px;
height: 63px;
left: 19px;
top: 73px;

background: #FFFFFF;
box-shadow: 0px 4px 32px rgba(0, 0, 0, 0.04);
border-radius: 15px;


/* Rectangle 1075 */

position: absolute;
width: 331px;
height: 63px;
left: 19px;
top: 326px;

background: #FFFFFF;
box-shadow: 0px 4px 32px rgba(0, 0, 0, 0.04);
border-radius: 15px;


/* Rectangle 1076 */

position: absolute;
width: 331px;
height: 63px;
left: 19px;
top: 413px;

background: #FFFFFF;
box-shadow: 0px 4px 32px rgba(0, 0, 0, 0.04);
border-radius: 15px;


/* Rectangle 1074 */

position: absolute;
width: 331px;
height: 142px;
left: 19px;
top: 160px;

background: #FFFFFF;
box-shadow: 0px 4px 32px rgba(0, 0, 0, 0.04);
border-radius: 15px;


/* Project Name */

position: absolute;
width: 60px;
height: 11px;
left: 35px;
top: 89px;

font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 9px;
line-height: 11px;

/* Color/Secondery */
color: #6E6A7C;



/* Star Date */

position: absolute;
width: 42px;
height: 11px;
left: 71px;
top: 342px;

font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 9px;
line-height: 11px;

/* Color/Secondery */
color: #6E6A7C;



/* End Date */

position: absolute;
width: 41px;
height: 11px;
left: 71px;
top: 429px;

font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 9px;
line-height: 11px;

/* Color/Secondery */
color: #6E6A7C;



/* Description */

position: absolute;
width: 50px;
height: 11px;
left: 35px;
top: 176px;

font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 9px;
line-height: 11px;

/* Color/Secondery */
color: #6E6A7C;



/* Iconly/Bold/Arrow - Down 3 */

position: absolute;
width: 24px;
height: 24px;
left: 310px;
top: 345px;



/* Iconly/Bold/Arrow - Down 2 */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;



/* Arrow - Down 2 */

position: absolute;
width: 12px;
height: 10px;
left: 6px;
top: 7px;



/* Arrow - Down 2 */

position: absolute;
left: 25%;
right: 25%;
top: 29.17%;
bottom: 29.17%;

/* Color/Black */
background: #24252C;


/* Iconly/Bold/Arrow - Down 4 */

position: absolute;
width: 24px;
height: 24px;
left: 310px;
top: 432px;



/* Iconly/Bold/Arrow - Down 2 */

position: absolute;
left: 0%;
right: 0%;
top: 0%;
bottom: 0%;



/* Arrow - Down 2 */

position: absolute;
width: 12px;
height: 10px;
left: 6px;
top: 7px;



/* Arrow - Down 2 */

position: absolute;
left: 25%;
right: 25%;
top: 29.17%;
bottom: 29.17%;

/* Color/Black */
background: #24252C;


/* Ellipse 17 */

position: absolute;
width: 310px;
height: 7px;
left: 28px;
top: 562px;

/* Color/Primary */
background: #5F33E1;
filter: blur(15px);


/* Rectangle 1 */

position: absolute;
width: 331px;
height: 52px;
left: 16px;
top: 515px;

/* Color/Primary */
background: #5F33E1;
border-radius: 14px;


/* Add Project */

position: absolute;
width: 111px;
height: 24px;
left: 126px;
top: 529px;

/* Lexend Deca/Semi Bold/19px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 600;
font-size: 19px;
line-height: 24px;
/* identical to box height */
text-align: center;

color: #FFFFFF;



/* Office Project */

position: absolute;
width: 94px;
height: 18px;
left: 35px;
top: 102px;

/* Lexend Deca/Regular/14px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 14px;
line-height: 18px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* 01 May, 2022 */

position: absolute;
width: 88px;
height: 18px;
left: 71px;
top: 355px;

/* Lexend Deca/Regular/14px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 14px;
line-height: 18px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* 30 June, 2022 */

position: absolute;
width: 93px;
height: 18px;
left: 71px;
top: 442px;

/* Lexend Deca/Regular/14px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 14px;
line-height: 18px;
/* identical to box height */

/* Color/Black */
color: #24252C;



/* Has to do some optimisation */

position: absolute;
width: 154px;
height: 14px;
left: 35px;
top: 199px;

/* Lexend Deca/Regular/11px */
font-family: 'Lexend Deca';
font-style: normal;
font-weight: 400;
font-size: 11px;
line-height: 14px;
/* identical to box height */

/* Color/Secondery */
color: #6E6A7C;



/* vuesax/bulk/calendar */

position: absolute;
width: 24px;
height: 24px;
left: 35px;
top: 345px;



/* vuesax/bulk/calendar */

position: absolute;
width: 24px;
height: 24px;
left: 35px;
top: 432px;




### Step 7.1: Create Todo Item Card Widget

**File**: `lib/features/todo/presentation/widgets/todo_item_card.dart`
- Match Figma card design exactly
- Show: title, description (truncated), completion status, date
- Add checkbox for completion toggle
- Add tap handler for navigation
- Add smooth animations

Design checklist:
- [ ] Correct card elevation/shadow
- [ ] Proper padding inside card
- [ ] Checkbox matches Figma style
- [ ] Text styles match Figma
- [ ] Completion state visual feedback
- [ ] Date format matches design

### Step 7.2: Create Empty State Widget

**File**: `lib/features/todo/presentation/widgets/empty_state_widget.dart`
- Match Figma empty state design
- Include illustration/icon
- Add message text
- Add call-to-action if shown in Figma

### Step 7.3: Create Todo List Page

**File**: `lib/features/todo/presentation/pages/todo_list_page.dart`

Implementation checklist:
- [ ] Use `BlocProvider` to provide `TodoBloc`
- [ ] Use `BlocBuilder` or `BlocConsumer` for state management
- [ ] AppBar matches Figma design
- [ ] Floating Action Button (FAB) matches Figma
- [ ] Loading state shows appropriate indicator
- [ ] Error state shows snackbar or error widget
- [ ] Empty state shows EmptyStateWidget
- [ ] Loaded state shows ListView of TodoItemCards
- [ ] Pull-to-refresh functionality
- [ ] Navigation to add todo page
- [ ] Navigation to detail page on card tap
- [ ] Smooth animations and transitions

Layout structure:
```dart
Scaffold(
  appBar: CustomAppBar(...), // Match Figma
  body: BlocConsumer<TodoBloc, TodoState>(
    listener: (context, state) {
      // Handle errors, success messages
    },
    builder: (context, state) {
      if (state is TodoLoading) return LoadingWidget();
      if (state is TodoError) return ErrorWidget();
      if (state is TodosLoaded) {
        if (state.todos.isEmpty) return EmptyStateWidget();
        return RefreshIndicator(
          onRefresh: () => _loadTodos(),
          child: ListView.builder(...),
        );
      }
      return SizedBox();
    },
  ),
  floatingActionButton: CustomFAB(...), // Match Figma
)
```

**Testing**: 
- [ ] Screen displays correctly
- [ ] Loading states work
- [ ] Can navigate to add todo
- [ ] Can navigate to detail on tap
- [ ] Design matches Figma exactly

---

## SECTION 8: Presentation Layer - UI (Add/Edit Todo Screen)

### Step 8.1: Create Custom Text Field Widget

**File**: `lib/features/todo/presentation/widgets/custom_text_field.dart`
- Match Figma input field design
- Include label, hint text, validation
- Show error messages
- Proper focus states

Design checklist:
- [ ] Border style matches Figma
- [ ] Label position and style
- [ ] Error state styling
- [ ] Focus state styling
- [ ] Padding and spacing

### Step 8.2: Create Add/Edit Todo Page

**File**: `lib/features/todo/presentation/pages/add_todo_page.dart`

Implementation checklist:
- [ ] Form with title and description fields
- [ ] Form validation
- [ ] Save button matches Figma
- [ ] Cancel button/back action
- [ ] Loading state during save
- [ ] Success feedback
- [ ] Error handling
- [ ] Keyboard handling
- [ ] Support both add and edit modes

Features:
1. **Form validation**:
   - Title required, minimum 3 characters
   - Description required

2. **Save functionality**:
   - Disable button during save
   - Show loading indicator
   - Navigate back on success
   - Show error on failure

3. **Edit mode**:
   - Pre-fill fields if editing
   - Change title to "Edit Todo"
   - Update instead of create

**Testing**: 
- [ ] Can add new todo
- [ ] Validation works
- [ ] Loading states work
- [ ] Success navigation works
- [ ] Design matches Figma

---

## SECTION 9: Presentation Layer - UI (Todo Detail Screen)

**File**: `lib/features/todo/presentation/pages/todo_detail_page.dart`

Implementation checklist:
- [ ] Display full todo details
- [ ] AppBar with edit and delete actions
- [ ] Completion toggle button
- [ ] Created/updated date display
- [ ] Loading state
- [ ] Error handling
- [ ] Confirmation dialog for delete
- [ ] Navigation to edit screen
- [ ] Auto-reload after edit

Layout features:
- Title display
- Description (full text)
- Status badge
- Timestamps
- Action buttons (edit, delete, toggle status)

Action flows:
1. **Edit**: Navigate to add_todo_page in edit mode
2. **Delete**: Show confirmation dialog → delete → navigate back
3. **Toggle**: Update status → show feedback → reload

**Testing**: 
- [ ] Detail screen displays correctly
- [ ] Can toggle completion
- [ ] Can navigate to edit
- [ ] Delete with confirmation works
- [ ] Design matches Figma

---

## SECTION 10: Main App Setup

### Step 10.1: Update Main File

**File**: `lib/main.dart`

Implementation:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseConfig.initialize();
  
  // Initialize dependencies
  await init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        // Apply theme from Figma
      ),
      home: BlocProvider(
        create: (_) => sl<TodoBloc>()..add(LoadTodosEvent()),
        child: const TodoListPage(),
      ),
    );
  }
}
```

### Step 10.2: Set up Supabase Database

1. Create Supabase project
2. Create `todos` table:
```sql
CREATE TABLE todos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  is_completed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add index for better performance
CREATE INDEX idx_todos_created_at ON todos(created_at DESC);

-- Add trigger for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_todos_updated_at 
  BEFORE UPDATE ON todos
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
```

3. Enable Row Level Security (RLS) if needed
4. Get Project URL and anon key
5. Update `lib/core/network/supabase_client.dart` with credentials

**Testing**: 
- [ ] App runs without errors
- [ ] Can connect to Supabase
- [ ] Theme applied correctly

---

## SECTION 11: Polishing & Final Touches

### Step 11.1: Add Loading Indicators
- Ensure all async operations show loading state
- Use CircularProgressIndicator or custom loader matching design

### Step 11.2: Add Error Handling
- Show user-friendly error messages
- Add retry mechanisms where appropriate
- Handle network errors gracefully

### Step 11.3: Add Animations
- Page transitions
- Card animations
- Button press feedback
- List item animations

### Step 11.4: Responsive Design
- Test on different screen sizes
- Ensure proper overflow handling
- Responsive padding/margins

### Step 11.5: Code Quality
- Remove unused imports
- Add comments for complex logic
- Follow Dart style guide
- Run `flutter analyze` and fix issues
- Run `dart format .` for formatting

---

## SECTION 12: Testing & Verification

### Step 12.1: Manual Testing Checklist
- [ ] Load todos successfully
- [ ] Add new todo
- [ ] Edit existing todo
- [ ] Delete todo with confirmation
- [ ] Toggle todo completion status
- [ ] View todo details
- [ ] Pull to refresh
- [ ] Handle empty state
- [ ] Handle error states
- [ ] Handle loading states
- [ ] Navigation flows work correctly
- [ ] Back button behavior
- [ ] Design matches Figma 100%

### Step 12.2: Build APK
```bash
flutter build apk --release
```
APK location: `build/app/outputs/flutter-apk/app-release.apk`

### Step 12.3: Final Code Review
- Clean architecture layers respected
- No business logic in UI
- No UI code in domain layer
- Proper error handling everywhere
- Code is well-commented
- No hardcoded values (use constants)

---

## SECTION 13: GitHub & Submission

### Step 13.1: Prepare Repository
```bash
git init
git add .
git commit -m "Initial commit: Clean Architecture Todo App"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

### Step 13.2: Create README.md
Include:
- Project description
- Features list
- Screenshots
- Architecture diagram
- Setup instructions
- Supabase setup guide
- Dependencies list
- How to run the app

### Step 13.3: Submission Checklist
- [ ] Code pushed to GitHub
- [ ] README.md is comprehensive
- [ ] APK uploaded to Google Drive/OneDrive
- [ ] APK link shared
- [ ] GitHub repository is public
- [ ] All requirements met

---

## Important Notes

### Clean Architecture Rules
1. **Domain layer**: Pure Dart, no Flutter or external dependencies
2. **Data layer**: Implements domain interfaces, handles data conversion
3. **Presentation layer**: Only UI and state management
4. **Dependency flow**: Presentation → Domain ← Data (arrows point inward)

### Code Quality Standards
- Use `const` constructors where possible
- Prefer `final` over `var`
- Use meaningful variable names
- Add comments for complex logic
- Follow single responsibility principle
- Keep functions small and focused

### Figma Design Adherence
- Use exact colors from Figma
- Match spacing and padding values
- Use same font families and sizes
- Replicate shadows and elevations
- Match border radius values
- Use same icon styles

### BLoC Best Practices
- Don't emit states in constructors
- Always handle all state types
- Use `BlocConsumer` for side effects
- Don't put business logic in BLoC (use use cases)
- Keep BLoC focused on state management

---

## Troubleshooting

### Common Issues

**Supabase connection fails**:
- Verify URL and anon key are correct
- Check internet connection
- Ensure Supabase project is active

**BLoC not updating UI**:
- Verify BlocProvider is above the widget tree
- Check if events are being added correctly
- Ensure new state instances are being emitted

**Build errors**:
- Run `flutter clean`
- Run `flutter pub get`
- Check for typos in import statements

**Design doesn't match Figma**:
- Double-check color values
- Verify font sizes and weights
- Check spacing values
- Inspect element in Figma for exact values

---

## Success Criteria

Your implementation is complete when:
- ✅ All features work correctly
- ✅ Design matches Figma exactly
- ✅ Clean architecture is properly implemented
- ✅ BLoC state management works flawlessly
- ✅ Supabase integration is functional
- ✅ No errors or warnings
- ✅ Code is clean and well-organized
- ✅ App runs smoothly without crashes
- ✅ APK builds successfully

---

## Timeline Recommendation

- **Day 1 Morning**: Sections 1-3 (Setup, Core, Domain)
- **Day 1 Afternoon**: Sections 4-6 (Data, DI, BLoC)
- **Day 1 Evening**: Section 7 (Todo List UI)
- **Day 2 Morning**: Sections 8-9 (Add/Edit, Detail UI)
- **Day 2 Afternoon**: Sections 10-11 (Main setup, Polishing)
- **Day 2 Evening**: Sections 12-13 (Testing, Submission)

---

## Final Reminders

1. **Work section by section** - Don't skip ahead
2. **Test after each section** - Catch issues early
3. **Follow Figma exactly** - This is critical
4. **Keep architecture clean** - Don't mix layers
5. **Handle errors properly** - User experience matters
6. **Comment your code** - Make it interview-ready
7. **Test thoroughly** - Ensure everything works

Good luck with your interview task! 🚀