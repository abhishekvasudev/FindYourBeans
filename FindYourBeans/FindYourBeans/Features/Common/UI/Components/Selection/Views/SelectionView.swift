import SwiftUI

enum LayoutType {
    case list
    case grid(columns: [GridItem])
    case dynamic
}

enum SelectionType {
    case single
    case multi(max: Int)
}

struct SelectionView<Cell: View, Content: View, T: SelectionItemProtocol>: View {
    
    private let layoutType: LayoutType
    private let cell: (T, CGFloat) -> Cell
    private let content: () -> Content
    private let selectedItem: (T?) -> Void
    
    @StateObject private var selectionViewModel: SelectionViewModel<T>
    
    init(selectionItems: [T],
         layoutType: LayoutType,
         selectionType: SelectionType = .single,
         @ViewBuilder cell: @escaping (T, CGFloat) -> Cell,
         @ViewBuilder content: @escaping () -> Content,
         selectedItem: @escaping (T?) -> Void) {
        self.layoutType = layoutType
        self.cell = cell
        self.content = content
        self.selectedItem = selectedItem
        self._selectionViewModel = StateObject(wrappedValue: SelectionViewModel<T>(selectionItems: selectionItems, selectionType: selectionType))
    }
    
    var body: some View {
        layoutView
    }
    
    @ViewBuilder
    private var layoutView: some View {
        switch layoutType {
        case .list:
            listView
        case .grid(let columns):
            gridView(columns: columns)
        case .dynamic:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func gridView(columns: [GridItem]) -> some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVGrid(columns: columns, spacing: Padding.sixteen) {
                    ForEach(selectionViewModel.items, id: \.id) { vm in
                        gridContentView(vm: vm, width: proxy.size.width)
                    }
                }
                content()
            }
            .scrollIndicators(.hidden)
        }
    }
    
    @ViewBuilder
    private func gridContentView(vm: T, width: CGFloat) -> some View {
        cell(vm, width)
            .onTapGesture {
                withAnimation(.linear) {
                    selectionViewModel.updateSelection(for: vm.index)
                }
                selectedItem(selectionViewModel.getVM(vm: vm))
            }
    }
    
    @ViewBuilder
    private var listView: some View {
        List(selectionViewModel.items, id: \.id) { vm in
            listContentView(vm: vm)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func listContentView(vm: T) -> some View {
        cell(vm, 0)
            .onTapGesture {
                withAnimation(.linear) {
                    selectionViewModel.updateSelection(for: vm.index)
                }
                selectedItem(selectionViewModel.getVM(vm: vm))
            }
    }
    
}
