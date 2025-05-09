import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

protocol URN {
    associatedtype Derived: Decodable
    var endPoint: EndPoint { get }
    var baseURLType: BaseURLType { get }
    var queryPath: String? { get }
    var method: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var body: Data? { get }
    var urlQueryItems: [URLQueryItem] { get }
    var headers: [String: String]? { get }
    func getURLRequest() -> URLRequest?
}

extension URN {
    
    var queryPath: String? {
        return nil
    }
    
    var urlQueryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        if let parameters = parameters {
            for eachQueryParam in parameters {
                queryItems.append(URLQueryItem(name: eachQueryParam.key, value: eachQueryParam.value))
            }
        }
        return queryItems
    }
    
    func getURLRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURLType.baseURLString + endPoint.rawValue),
            let _url = urlComponents.url else {
            return nil
        }
        urlComponents.queryItems = urlQueryItems
        var request = URLRequest(url: _url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        print("###### getURLRequest request = \(request)")
        print(request)
        return request
    }
}

protocol URLEncodedURN: URN {}
extension URLEncodedURN {
        
    var method: HTTPMethod {
        return .get
    }
    
    var body: Data? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: String]? {
        return nil
    }
}

//Mock URN
struct AdviceURN: URLEncodedURN {
    typealias Derived = Advice
    var baseURLType: BaseURLType {
        return .appURL
    }
    var endPoint: EndPoint {
        return .advice
    }
    var method: HTTPMethod { return .get}
}


// Mock DataModel
struct Advice: Codable {
    let slip: Slip
}

struct Slip: Codable {
    let id: Int
    let advice: String
}

//struct LoginURN: URLEncodedURN {
//
//    typealias Derived = UserDTO
//    
//    var baseURLType: BaseURLType {
//        return .mmURL
//    }
//    
//    var endPoint: EndPoint {
//        return .login
//    }
//    var method: HTTPMethod { return .post}
//}
//
//struct ImageListURN: URLEncodedURN {
//
//    typealias Derived = [Photo]
//    
//    var baseURLType: BaseURLType {
//        return .picSum
//    }
//    
//    var endPoint: EndPoint {
//        return .imageList
//    }
//    var method: HTTPMethod { return .get}
//}
