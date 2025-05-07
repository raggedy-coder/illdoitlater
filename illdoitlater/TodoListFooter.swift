HStack(alignment: .center) {
            Image(systemName: "line.3.horizontal.decrease").opacity(0) //TODO: This is inefficient
            Spacer()
            Button("New To Do", systemImage: "plus.circle") {
                showingNewTodoView.toggle()
            }.sheet(isPresented: $showingNewTodoView) {
                NewTodoView()
            }
            Spacer()
            Menu {
                Picker("Filter", selection: $filterOption) {
                    ForEach(FilterOption.allCases) {
                        Text($0.text).tag($0)
                    }
                }
                Button("A button", systemImage: isShowCompleted ? "checkmark" : "plus") {
                    isShowCompleted.toggle()
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
            }.menuOrder(.fixed)
        }.padding([.leading, .trailing, .bottom])