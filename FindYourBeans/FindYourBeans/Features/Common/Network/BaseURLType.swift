import Foundation

enum BaseURLType {
    
    case appURL
    case mmURL
    case picSum
    
    var baseURLString: String {
        switch self {
        case .appURL:
            return "https://api.adviceslip.com"
        case .mmURL:
            return "http://fakerestapi.azurewebsites.net/api"
        case .picSum:
            return "https://picsum.photos/v2"
        }
    }
}
