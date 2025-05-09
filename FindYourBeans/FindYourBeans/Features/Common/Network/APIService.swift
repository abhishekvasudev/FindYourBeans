import Foundation
import Combine

class APIService {
    
    func makeRequest<T: URN>(with urnData: T) -> AnyPublisher<T.Derived, AppError> {
        guard let request = urnData.getURLRequest() else {
            return Fail<T.Derived, AppError>(error: AppError.urnDataMissing(endpoint: urnData.endPoint.rawValue)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .handleResponse()
    }
    
    func downloadData(for url: URL) -> AnyPublisher<Data, AppError> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                return data
        }
        .receive(on: DispatchQueue.main)
        .mapError({ (_) -> AppError in return AppError.downloadError })
        .eraseToAnyPublisher()
    }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    
    func handleResponse<Derived: Decodable>() -> AnyPublisher<Derived, AppError> {
        let handleResponsePublisher = tryMap { (output) in
            guard let httpResponse = output.response as? HTTPURLResponse else {
                throw AppError.unknownError
            }
            
            switch httpResponse.statusCode {
            case 200:
                return output.data
            case 404:
                throw AppError.unauthorisedAccess
            default:
                throw AppError.unknownStatusCode
            }
        }
        .decode(type: Derived.self, decoder: JSONDecoder())
        .mapError({ (_) -> AppError in return AppError.parsingError })
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
        
        return handleResponsePublisher
    }
}
