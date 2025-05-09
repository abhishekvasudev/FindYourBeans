import SwiftUI

enum AppStringInterpolated {
    case km(Int)
}

extension AppStringInterpolated: Localizable {
    
    var localised: LocalizedStringKey {
        switch self {
        case .km(let value):
            LocalizedStringKey("\(value) com.app.Axcel.km")
        }
    }
    
}
