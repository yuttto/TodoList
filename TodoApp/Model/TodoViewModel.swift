
import Foundation

//データの更新を監視する→ObservableObjectとView側でsetで使用StateObject
class TodoViewModel: ObservableObject {
    
    //@Published → Viewがこの配列の変更を検知して保存され(saveTodos)再描画する
    @Published var todos: [TodoItem] = [] {
        didSet {
            saveTodos()
        }
    }
    
    private let key = "todos"
    
    //ViewModelが生成されたタイミングで、UserDefaultsからToDoデータを読み込む
    init() {
        loadTodos()
    }
    
    //viewModel.addTodoからタイトルがデータ入力される
    func addTodo(title: String) {
        //インスタンス生成して、var[todos]にnewTodoを追加（保存ではない）
        let newTodo = TodoItem(title: title, isDone: false)
        todos.append(newTodo)
    }

    func toggleDone(for todo: TodoItem) {
        //配列の中の一件のみにチェエクマーク表示を切り替える、配列IDの何番目がタップされたか検知するロジック
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isDone.toggle()
        }
    }
    //自動で何番目がスワイプで削除されたか検知
    func delete(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }

    private func saveTodos() {
        if let data = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func loadTodos() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) {
            todos = decoded
        }
    }
}
