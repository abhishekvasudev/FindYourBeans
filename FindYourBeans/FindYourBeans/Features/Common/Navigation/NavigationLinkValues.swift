import SwiftUI

//Update case and body for adding a New Destination
enum NavigationDestination: Hashable, View {
    case root
    case onboarding
//    case login
//    case twoStepVerification
//    case twoStepVerificationOTP(phoneNumber: String)
    
    var body: some View {
        switch self {
        case .root:
            SplashView()
        case .onboarding:
            OnboardingView()
//        case .login:
//            LoginView()
//        case .twoStepVerification:
//            TwoStepVerificationView()
//        case .twoStepVerificationOTP(let phoneNumber):
//            TwoStepVerificationOTPView(phoneNumber: phoneNumber)
        }
    }
}
