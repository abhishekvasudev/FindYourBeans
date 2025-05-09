import SwiftUI

protocol Localizable {
    var localised: LocalizedStringKey { get }
}

enum AppText {
    case string(String)
    case localised(AppString)
    
    var string: String {
        switch self {
        case .string(let string):
            return string
        default:
            return ""
        }
    }
    
    var localised: Localizable {
        switch self {
        case .localised(let localised):
            return localised
        default:
            return AppString.empty
        }
    }
}
