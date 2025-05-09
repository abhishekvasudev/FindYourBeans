import Foundation

class SelectionItemViewModel: SelectionItemProtocol, ObservableObject {
    typealias T = SelectionProtocol
    
    let item: T
    let index: Int
    let id: String
    
    @Published private(set) var selected: Bool
    
    init(id: String,
         index: Int,
         item: T,
         selected: Bool = false) {
        self.id = id
        self.index = index
        self.item = item
        self.selected = selected
    }
    
    func toggleSelected() {
        selected.toggle()
    }
    
    var isSelected: Bool {
        return selected
    }
    
    var text: AppText {
        return item.text
    }
    
}
