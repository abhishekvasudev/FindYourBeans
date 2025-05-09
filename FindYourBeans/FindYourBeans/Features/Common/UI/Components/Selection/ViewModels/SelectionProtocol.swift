import Foundation

protocol SelectionProtocol {
    var id: String { get }
    var text: AppText { get }
}

protocol SelectionItemProtocol: SelectionProtocol {
    associatedtype T
    var item: T { get }
    var index: Int { get }
    var isSelected: Bool { get }
    func toggleSelected()
}
