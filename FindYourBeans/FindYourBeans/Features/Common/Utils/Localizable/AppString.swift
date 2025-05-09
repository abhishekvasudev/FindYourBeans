import SwiftUI

enum AppString: String {
    case empty = ""
    
    // MARK: - Alert Messages
    case alertNoInternetConnection = "Alert.NoInternetConnection"
    
    // MARK: - Common
    case confirmation = "Confirmation"
    case done = "Done"
    case home = "Home"
    case oops = "Oops!"
    case other = "Other"
    
    // MARK: - Errors
    case errorAllFieldsAreMandatory = "Error.AllFieldsAreMandatory"
    case errorDownloadFailed = "Error.Download.Failed"
    case errorParsingError = "Error.ParsingError"
    case errorSomethingWentWrong = "Error.Something.Went.Wrong"
    case errorText = "Error.Text"
    case errorUnauthorisedAccess = "Error.Unauthorised.Access"
    case errorUnknownError = "Error.UnknownError"
    case errorUnknownStatusCode = "Error.UnknownStatusCode"
    case errorUrnDataMissing = "Error.URNData.Missing"
    
    // MARK: - Image List View
    case imageList = "ImageList"
    
    // MARK: - Onboarding View
    case alreadyAMember = "AlreadyAMember"
    case signUpButtonTitle = "SignUp.Button.Title"
    
    // MARK: - Sign In View
    case emailPlaceholder = "Email.Placeholder"
    case forgotPassword = "ForgotPassword"
    case password = "Password"
    case signIn = "SignIn"
    case signUp = "SignUp"
    
    // MARK: - Sign Up View
    case createAccount = "Create.Account"
    case createAccountPasswordPlaceholder = "CreateAccount.Password.Placeholder"
    case firstName = "First.Name"
    case termsAndCondition = "Terms.And.Condition"
    
    // MARK: - Validation Errors
    case validationErrorEmpty = "Validation.Error.Empty"
    case validationErrorInvalidEmail = "Validation.Error.InValidEmail"
    
    // MARK: - Previous Keys
    case Continue = "Continue"
    case phoneNumberPlaceholder = "Phone Number"
    case verify = "Verify"
    case biometric = "biometrics.action"
    case forgotPasswordAction = "forgot.password.action"
    case getStarted = "get.started.action"
    case login = "login.action"
    case loginBody = "login.body"
    case loginTitle = "login.title"
    case onboardingBody = "onboarding.body"
    case onboardingTitle = "onboarding.title"
    case orDivider = "or.divider"
    case passwordPlaceholder = "password.placeholder"
    case splashTitle = "splash.title"
}

extension AppString: Localizable {
    
    var localised: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
    
}
