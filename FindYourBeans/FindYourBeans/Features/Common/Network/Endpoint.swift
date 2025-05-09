import Foundation

enum EndPoint {
    
    case login
    case advice
    case imageList
    
    var rawValue: String {
        switch self {
        case .advice:
            return "/advice"
        case .login:
            return "/Users"
        case .imageList:
            return "/list"
        }
    }
}
