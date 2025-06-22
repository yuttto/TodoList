
import SwiftUI

struct TodoListView: View {
    //データの更新を監視する→ObservableObject→StateObject
    @StateObject private var viewModel = TodoViewModel()
    @State private var newTitle = ""

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("新しいToDo", text: $newTitle)
                        .textFieldStyle(.roundedBorder)
                    //func addTodo
                    Button("追加") {
                        guard !newTitle.isEmpty else { return }
                        viewModel.addTodo(title: newTitle)
                        newTitle = ""
                    }
                }
                .padding()

                List {
                    //配列をtodoに格納
                    ForEach(viewModel.todos) { todo in
                        HStack {//横並び表示
                            Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    viewModel.toggleDone(for: todo)
                                }
                            Text(todo.title)
                        }
                    }
                    //リストを削除
                    .onDelete(perform: viewModel.delete)
                }
            }
            .navigationTitle("ToDoリスト")
        }
    }
}
#Preview {
    TodoListView()
}
