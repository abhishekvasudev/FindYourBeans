import SwiftUI

struct TextFieldView: View {
    
    enum TextFieldViewType {
        case otp
        case secure
        case action(secure: Bool, icon: ImageResource, color: ColorStyleProtocol, action: (() -> Void)?)
        case `default`
    }
    
    enum TextFieldViewStyle {
        case bordered(radius: CGFloat, border: CGFloat, borderColor: ColorStyleProtocol)
        case filled(radius: CGFloat, background: ColorStyleProtocol)
        case borderFilled(radius: CGFloat, border: CGFloat, borderColor: ColorStyleProtocol, background: ColorStyleProtocol)
        case none
    }
    
    private let padding: CGFloat = Padding.eight
    private let iconSize: CGFloat = Size.twentyFour
    
    private let type: TextFieldViewType
    private let placeholder: AppText
    private let style: TextFieldViewStyle
    private let fontName: FontName
    private let fontStyle: AppFontStyle
    private let foreground: (text: ColorStyleProtocol, placeholder: ColorStyleProtocol)
    
    @Binding private var text: String
    
    init(placeholder: AppText,
         text: Binding<String>,
         type: TextFieldViewType = .default,
         style: TextFieldViewStyle = .bordered(radius: CornerRadius.fourty, border: Border.one, borderColor: ColorStyle.color(.gray)),
         fontName: FontName = .inter,
         fontStyle: AppFontStyle = .title3Regular,
         foreground: (text: ColorStyle, placeholder: ColorStyle) = (ColorStyle.color(.gray), ColorStyle.color(.gray))
    ) {
        self.placeholder = placeholder
        self._text = text
        self.type = type
        self.fontName = fontName
        self.fontStyle = fontStyle
        self.style = style
        self.foreground = foreground
    }
    
    var body: some View {
        textFieldView
            .contentView { content in
                textFieldStyle(content: content)
            }
    }
    
    @ViewBuilder
    private var textFieldView: some View {
        switch type {
        case .otp:
            textFieldView()
        case .secure:
            textFieldView(isSecure: true)
        case .action(let secure, let icon, let color, let action):
            textFieldActionView(secure: secure, icon: icon, color: color, action: action)
        case .default:
            textFieldView()
        }
    }
    
    @ViewBuilder 
    private func textFieldView(isSecure: Bool = false) -> some View {
        ZStack(alignment: .leading) {
            placeholderView
            if isSecure {
                secureField
            } else {
                textField
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func textFieldActionView(secure: Bool, icon: ImageResource, color: ColorStyleProtocol, action: (() -> Void)?) -> some View {
        ZStack(alignment: .leading) {
            placeholderView
            HStack {
                if secure {
                    secureField
                } else {
                    textField
                }
                iconButton(image: icon, color: color, action: action)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private var placeholderView: some View {
        if text.isEmpty {
            TextView(
                text: placeholder,
                fontName: fontName,
                fontStyle: fontStyle,
                foreground: foreground.placeholder
            )
            .padding(.leading, Padding.eight)
        }
    }
    
    @ViewBuilder
    private var textField: some View {
        TextField("", text: $text)
            .font(name: fontName, style: fontStyle)
            .foregroundStyle(foreground.text.style)
            .padding(Padding.zero)
    }
    
    @ViewBuilder
    private var secureField: some View {
        SecureField("", text: $text)
            .font(name: fontName, style: fontStyle)
            .foregroundStyle(foreground.text.style)
            .padding(Padding.zero)
    }
    
    @ViewBuilder
    private func iconButton(image: ImageResource, color: ColorStyleProtocol, action: (() -> Void)?) -> some View {
        ButtonView(
            type: .icon(image),
            foreground: color,
            style: .none,
            frame: .rect(width: iconSize, height: iconSize, maxWidth: nil)) {
                action?()
            }
    }
    
    @ViewBuilder
    private func textFieldStyle<Content: View>(content: Content) -> some View {
        switch style {
        case .bordered(let radius, let border, let borderColor):
            content
                .overlay {
                    RoundedRectangle(cornerRadius: radius)
                        .strokeBorder(borderColor.style, lineWidth: border)
                }
        case .filled(let radius, let background):
            content
                .background {
                    RoundedRectangle(cornerRadius: radius)
                        .fill(background.style)
                }
        case .borderFilled(let radius, let border, let borderColor, let background):
            content
                .background {
                    RoundedRectangle(cornerRadius: radius)
                        .fill(background.style)
                        .strokeBorder(borderColor.style, lineWidth: border)
                }
        case .none:
            content
        }
    }
    
}

struct TextFieldViewPreview: View {
    
    @State private var text: String = ""
    
    var body: some View {
        TextFieldView(
            placeholder: .string("Placeholder"),
            text: $text,
            type: .action(secure: false, icon: .eye, color: ColorStyle.linearGraident(Color.main), action: {
                
            })
        )
    }
    
}

#Preview {
    TextFieldViewPreview()
}

