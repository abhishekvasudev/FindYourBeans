import SwiftUI

struct TextView: View {
    
    private let text: AppText
    private let fontName: FontName
    private let fontStyle: AppFontStyle
    private let foreground: ColorStyleProtocol
    
    init(text: AppText,
         fontName: FontName = .inter,
         fontStyle: AppFontStyle,
         foreground: ColorStyleProtocol = ColorStyle.color(.primary)) {
        self.text = text
        self.fontName = fontName
        self.fontStyle = fontStyle
        self.foreground = foreground
    }
    
    var body: some View {
        Group {
            switch text {
            case .string(let string):
                Text(string)
            case .localised(let localizable):
                Text(localizable.localised)
            }
        }
        .foregroundStyle(foreground.style)
        .font(name: fontName, style: fontStyle)
    }
    
}

#Preview {
    TextView(
        text: .string("Title"),
        fontStyle: .title2Bold
    )
}
