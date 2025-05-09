import SwiftUI

enum FontType: String {
    case bold = "Bold"
    case semiBold = "Semibold"
    case medium = "Medium"
    case regular = "Regular"
    case extraBold = "ExtraBold"
    case light = "Light"
    case extraLight = "ExtraLight"
}

enum FontName: String {
    case inter = "Inter"
    case impact = "impact"
}

struct AppFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    let name: FontName
    let style: AppFontStyle
    
    func body(content: Content) -> some View {
        let (type, size, textStyle) = AppFontStyle.font(style: style)
        let name = "\(name.rawValue)-\(type.rawValue)"
        let font = Font.custom(name, size: size, relativeTo: textStyle)
        return content.font(font)
    }
}
