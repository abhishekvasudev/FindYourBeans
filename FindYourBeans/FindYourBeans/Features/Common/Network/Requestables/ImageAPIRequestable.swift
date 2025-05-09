import Combine
import Foundation

struct ImageInteractor {
    private let imageListService: ImageService<URLSessionProvider>
    private let serviceProvider = URLSessionProvider()
    
    init() {
        imageListService = ImageService(with: serviceProvider)
    }
    
//    func fetchImageListPublisher() -> AnyPublisher<[Photo], AppError> {
//        return imageListService.imagePublisher(with: ImageListURN())
//    }
//    
//    func getImagePublisher(for url: URL) -> AnyPublisher<Data, AppError> {
//        return imageListService.downloadImagePublisher(for: url)
//    }
}

struct ImageService<T: NetworkServiceProvider> {

    var serviceProvider: T

    init(with serviceProvider: T) {
        self.serviceProvider = serviceProvider
    }

//    func imagePublisher(with urn: ImageListURN) -> AnyPublisher<[Photo], AppError> {
//        serviceProvider
//            .execute(with: urn)
//            .eraseToAnyPublisher()
//    }
//    
//    func downloadImagePublisher(for url: URL) -> AnyPublisher<Data, AppError> {
//        serviceProvider
//            .downloadData(for: url)
//            .eraseToAnyPublisher()
//    }
}
