import Foundation
import Combine

protocol NetworkServiceProvider {
    associatedtype URNType

    func execute<URNType: URN>(with urnType: URNType) -> AnyPublisher<URNType.Derived, AppError>
    func downloadData(for url: URL) -> AnyPublisher<Data, AppError>
}
