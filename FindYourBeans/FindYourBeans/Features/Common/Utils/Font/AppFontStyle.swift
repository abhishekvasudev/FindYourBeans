import SwiftUI

typealias FontStyleInfo = (style: FontType, size: CGFloat, textStyle: Font.TextStyle)

enum AppFontStyle {
    case largeTitleBold
    case largeTitleSemiBold
    case titleBold
    case titleSemiBold
    case title1Regular
    case title2Bold
    case title3Regular
    case title3SemiBold
    case title3Medium
    case headlineSemiBold
    case headline1SemiBold
    case bodyRegular
    case callout
    case subheadlineRegular
    case subheadlineMedium
    case subheadlineSemibold
    case footnote
    case captionSemiBold
    case caption2
    
    static func font(style: AppFontStyle) -> FontStyleInfo {
        switch style {
        case .largeTitleBold:
            return (.semiBold, 32, .largeTitle)
        case .largeTitleSemiBold:
            return (.semiBold, 28, .largeTitle)
        case .titleBold:
            return (.bold, 24, .title)
        case .titleSemiBold:
            return (.semiBold, 24, .title)
        case .title1Regular:
            return (.regular, 20, .title2)
        case .title2Bold:
            return (.bold, 18, .title2)
        case .title3Regular:
            return (.regular, 16, .title3)
        case .title3SemiBold:
            return (.semiBold, 16, .title3)
        case .title3Medium:
            return (.medium, 16, .title3)
        case .headlineSemiBold:
            return (.semiBold, 15, .headline)
        case .headline1SemiBold:
            return (.semiBold, 14, .headline)
        case .bodyRegular:
            return (.regular, 14, .body)
        case .callout:
            return (.regular, 13, .callout)
        case .subheadlineRegular:
            return (.regular, 12, .subheadline)
        case .subheadlineMedium:
            return (.medium, 12, .subheadline)
        case .subheadlineSemibold:
            return (.semiBold, 12, .subheadline)
        case .footnote:
            return (.regular, 12, .footnote)
        case .captionSemiBold:
            return (.semiBold, 11, .caption)
        case .caption2:
            return (.regular, 11, .caption2)
        }
    }
}
