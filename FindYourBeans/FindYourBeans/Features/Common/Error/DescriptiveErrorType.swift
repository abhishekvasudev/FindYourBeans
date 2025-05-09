import Foundation

protocol DescriptiveErrorType: Error, CustomStringConvertible {
    var title: AppText { get }
    func error() -> NSError
}

extension DescriptiveErrorType {
    
    var title: AppText {
        get {
            return .localised(.errorText)
        }
    }
    
    func error() -> NSError {
        return NSError(domain: _domain, code: _code, userInfo:
            [NSLocalizedDescriptionKey: self.description])
    }
}
