# Personal Goals
- Release a native ToDo app that strictly uses Apple first party features such as Xcode, Swift Packages and XCloud
- Provide a basic template for building SwiftUI apps using SwiftData
- Use Apple's Model-View as the architecture, similar to this WWDC video: https://developer.apple.com/videos/play/wwdc2019/226/

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
