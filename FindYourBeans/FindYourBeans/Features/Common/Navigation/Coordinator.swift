import Foundation

class Coordinator: ObservableObject {
    
    @Published var path: [NavigationDestination] = []

    func navigate(to destination: NavigationDestination) {
        switch destination {
        case .root:
            path = [.root]
        default:
            path.append(destination)
        }
    }
    
    func back() {
        if path.count > 1 {
            path.removeLast()
        }
    }

    /*func handleLink(url: URL) {
        if let destination = NavigationDestination(url: url) {
            navigate(to: destination)
        } else if let destination = NavigationDestination(universalLink: url) {
            navigate(to: destination)
        }
    }*/
    
}
