# Personal Goals
- Todo app for the non-commital
- Release a native ToDo app that strictly uses Apple first party features such as Xcode, Swift Packages and XCloud
- Provide a basic template for building SwiftUI apps using SwiftData
- Use Apple's Model-View as the architecture, similar to this WWDC video: https://developer.apple.com/videos/play/wwdc2019/226/

# Demo
Light | Dark
--- | ---
<img width="200" alt="dark-mode" src="https://github.com/user-attachments/assets/31b5b39a-f7ec-4e2f-9988-a2669cd44987" /> | <img width="200" alt="light-mode" src="https://github.com/user-attachments/assets/e46e602d-0f88-4bba-901b-b6976730f64e" />

Easy to use | Collapsible | Clear All Past Due
--- | --- | ---
![easytodo200](https://github.com/user-attachments/assets/ea43e6f7-9bba-4ed0-a47b-fdb0e71ab8b0) | ![clearpastdue](https://github.com/user-attachments/assets/e3cc076b-32c6-4777-9816-b0512a367fbd) | ![clearallpastdue](https://github.com/user-attachments/assets/a6fcc795-c592-4d29-aa22-6233705bcd59)

History | Edit & Delete
--- | ---
<img width="200" alt="completed-history" src="https://github.com/user-attachments/assets/994f9a8c-65aa-4f86-ac74-459ef588c814" /> | ![edit](https://github.com/user-attachments/assets/b411cf21-b0be-43c3-8129-66386203bed5)

# Coding Guidelines
Primarily follows the rules set by [Swift.org](https://www.swift.org/documentation/api-design-guidelines/)

## Homebrew Rules
- File names for extensions are prefixed by `+` (example: `+Date.swift`, `+Calendar.swift`)
- Use the `View` postfix for clarity (example: `NewTodoView` instead of `NewTodo`)
- In most cases, view components can just be written as is (example: `TodoListRow`, `TodoListTable`)
- Be restrictive with access control. Variables in views should be labelled as `private var` if only used within the scope, or `fileprivate var` if only used within the file.
- When using a for loop, use `.forEach()` instead of `for i in j {}` for consistency. No offense to `for i in j {}` enjoyers, just trying this one out.
- For boolean, use `is + verb` OR `has + noun` (example: isCompleted, isExpanded, hasChanges) except for state booleans used for pushing or popping new views. In that case use `isPresenting + viewName` (example: isPresentingTodoView, isPresentingAlert)
- For closure variables, use `on + functionName` (example: onSubmit, onExpandAll, onCollapseAll)
## Known Issues
- SwiftUI's DatePicker may toggle between different date formats when picking dates. [stackoverflow](https://stackoverflow.com/questions/66090210/swiftui-datepicker-jumps-between-short-and-medium-date-formats-when-changing-the)
