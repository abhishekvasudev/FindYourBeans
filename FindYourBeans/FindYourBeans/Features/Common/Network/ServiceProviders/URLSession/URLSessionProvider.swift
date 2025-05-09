import Foundation
import Combine

var subscriptions: Set<AnyCancellable> = []

/// URLSessionProvider helps in performing the network request using URLSession framework.
struct URLSessionProvider: NetworkServiceProvider {
    typealias URNType = URN
    

    func execute<URNType>(with urnType: URNType) -> AnyPublisher<URNType.Derived, AppError> where URNType : URN {
        guard let request = urnType.getURLRequest() else {
            return Fail<URNType.Derived, AppError>(error: AppError.urnDataMissing(endpoint: urnType.endPoint.rawValue)).eraseToAnyPublisher()
        }
        print("###### request = \(request)")
//        return URLSession.shared
//            .dataTaskPublisher(for: request)
//            .tryMap { response -> Data in
//                print("###### response = \(response)")
//                try? self.mapData(for: response.response)
//                print("###### response = \(response)")
//                return response.data
//            }
//            .decode(type: URNType.Derived.self, decoder: JSONDecoder())
//            .mapError({ error -> AppError in
//                print("###### error = \(error)")
//                if let error = error as? AppError {
//                    return error
//                } else {
//                    return AppError.parsingError
//                }
//            })
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap({ (data: Data, response: URLResponse) in
                return data
            })
            .decode(type: URNType.Derived.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                print("###### completion = \(completion)")
            }, receiveValue: { data in
                print("###### data = \(data)")
            })
            .store(in: &subscriptions)

        
        return Empty().eraseToAnyPublisher()
    }

    // TODO: - Need to implement
    func downloadData(for url: URL) -> AnyPublisher<Data, AppError> {
        return Empty().eraseToAnyPublisher()
    }
}

private extension URLSessionProvider {

    func mapData(for response: URLResponse) throws {
        print("###### mapData(for response: \(response)")
        let httpURLResponse = response as? HTTPURLResponse
        guard let statusCode = httpURLResponse?.statusCode else {
            throw AppError.unknownStatusCode
        }
        switch statusCode {
        case StatusCode.unauthorised.rawValue:
            throw AppError.unauthorisedAccess
        default:
            break
        }
    }
}
