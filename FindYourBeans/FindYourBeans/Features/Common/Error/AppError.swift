import Foundation

enum AppError: DescriptiveErrorType {
    
    //TODO: Separate Validation Errors
    case allFieldsAreMandatory
    case unknownError
    case unknownStatusCode
    case parsingError
    case unauthorisedAccess
    case urnDataMissing(endpoint: String)
    case downloadError
    case somethingWentWrong
    case custom(string: String)
    
    var description: String {
        switch  self {
        case .allFieldsAreMandatory:
            return AppText.localised(.errorAllFieldsAreMandatory).string
        case .unknownError:
            return AppText.localised(.errorUnknownError).string
        case .unknownStatusCode:
            return AppText.localised(.errorUnknownStatusCode).string
        case .parsingError:
            return AppText.localised(.errorParsingError).string
        case .unauthorisedAccess:
            return AppText.localised(.errorUnauthorisedAccess).string
        case .urnDataMissing:
            return AppText.localised(.errorUrnDataMissing).string
        case .downloadError:
            return AppText.localised(.errorDownloadFailed).string
        case .somethingWentWrong:
            return AppText.localised(.errorSomethingWentWrong).string
        case .custom(string: let error):
            return error
        }
    }
}
