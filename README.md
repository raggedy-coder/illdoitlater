# Coding Guidelines
Primarily follows the rules set by [Swift.org](https://www.swift.org/documentation/api-design-guidelines/)

## Homebrew Rules
- File names for extensions are prefixed by `+` (example: `+Date.swift`, `+Calendar.swift`)
- Use the `View` postfix for clarity (example: `NewTodoView` instead of `NewTodo`)
- In most cases, view components can just be written as is (example: `TodoListRow`, `TodoListTable`)
- Be restrictive with access control. Variables in views should be labelled as `private var` if only used within the scope, or `fileprivate var` if only used within the file.
- When using a for loop, use `.forEach()` instead of `for i in j {}` for consistency. No offense to `for i in j {}` enjoyers
- For boolean, use `is + verb` (example: isCompleted, isExpanded) except for state booleans used for pushing or popping new views. In that case use `showing + viewName` (example: showingNewTodoView, showingAlert)
