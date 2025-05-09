import Foundation

final class SelectionViewModel<T: SelectionItemProtocol>: ObservableObject {
    
    private let selectionType: SelectionType
    private var selectedIndex: Int?
    private var totalSelected: Int
    
    @Published private(set) var selectionItems: [T]
    
    @Published var optionSelected: Bool = false
    
    init(selectionItems: [T],
         selectionType: SelectionType,
         selectedIndex: Int? = nil,
         totalSelected: Int = 0) {
        self.selectionItems = selectionItems
        self.selectionType = selectionType
        self.selectedIndex = selectedIndex
        self.totalSelected = totalSelected
    }
    
    var items: [T] {
        self.selectionItems
    }
    
    var count: Int {
        self.selectionItems.count
    }
    
    func updateSelection(for index: Int) {
        switch selectionType {
        case .single:
            singleSelec(index: index)
        case .multi(let max):
            multiSelect(index: index, max: max)
        }
    }
    
    private func singleSelec(index: Int) {
        if selectedIndex == index {
            selectionItems[index].toggleSelected()
            selectedIndex = nil
        } else {
            selectionItems[index].toggleSelected()
            if let previousIndex = selectedIndex {
                selectionItems[previousIndex].toggleSelected()
            }
            selectedIndex = index
        }
    }
    
    private func multiSelect(index: Int, max: Int) {
        let isSelected = selectionItems[index].isSelected
        if !isSelected && totalSelected < max {
            selectionItems[index].toggleSelected()
            totalSelected += 1
            selectedIndex = index
        } else if isSelected {
            selectionItems[index].toggleSelected()
            totalSelected -= 1
            selectedIndex = totalSelected >= 0 ? index : nil
        } else {
            selectedIndex = nil
        }
    }
    
    func getVM(vm: T) -> T? {
        return selectedIndex != nil ? vm : nil
    }

    func toggleOptionSelected() {
        optionSelected.toggle()
    }
    
}
