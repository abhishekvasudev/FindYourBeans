import Foundation

enum ValidationError: DescriptiveErrorType {
    
    case empty
    case invalidEmail
    
    var description: String {
        switch self {
        case .empty:
            return AppText.localised(.validationErrorEmpty).string
        case .invalidEmail:
            return AppText.localised(.validationErrorInvalidEmail).string
        }
    }
}
