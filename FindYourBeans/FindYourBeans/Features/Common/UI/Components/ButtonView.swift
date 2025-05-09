import SwiftUI

struct ButtonView: View {
    
    enum ButtonStyle {
        case bordered(radius: CGFloat, border: CGFloat)
        case filled(radius: CGFloat)
        case none
    }
    
    enum ButtonType {
        case icon(ImageResource)
        case text(AppText)
        case iconText(ImageResource, AppText)
    }
    
    enum ButtonFrame {
        case height(CGFloat, maxWidth: CGFloat?)
        case rect(width: CGFloat, height: CGFloat, maxWidth: CGFloat?)
        case none
    }
    
    private let type: ButtonType
    private let foreground: ColorStyleProtocol
    private let background: ColorStyleProtocol
    private let style: ButtonStyle
    private let fontName: FontName
    private let fontStyle: AppFontStyle
    private let frame: ButtonFrame
    
    private let action: () -> Void
    
    init(type: ButtonType,
         foreground: ColorStyleProtocol = ColorStyle.color(.accentOrange),
         background: ColorStyleProtocol = ColorStyle.color(.white),
         style: ButtonStyle = .filled(radius: CornerRadius.thirtyTwo),
         fontName: FontName = .inter,
         fontStyle: AppFontStyle = .title2Bold,
         frame: ButtonFrame = .height(Height.fourtyEight, maxWidth: .infinity),
         action: @escaping () -> Void) {
        self.type = type
        self.foreground = foreground
        self.background = background
        self.style = style
        self.fontName = fontName
        self.fontStyle = fontStyle
        self.frame = frame
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            buttonLabel
        })
    }
    
    //If we move the .contentView of buttonStyle to Button on body the whole button tap animation gets disabled only label will animate
    @ViewBuilder
    private var buttonLabel: some View {
        Group {
            switch type {
            case .icon(let imageResource):
                buttonIcon(resource: imageResource)
            case .text(let text):
                buttonText(text: text)
            case .iconText(let imageResource, let text):
                HStack(spacing: Padding.eight) {
                    buttonIcon(resource: imageResource)
                    buttonText(text: text)
                }
            }
        }
        .contentView { content in
            buttonFrame(content: content)
        }
        .contentView { content in
            buttonStyle(content: content)
        }
    }
    
    @ViewBuilder
    private func buttonText(text: AppText) -> some View {
        TextView(
            text: text,
            fontName: fontName,
            fontStyle: fontStyle,
            foreground: foreground
        )
    }
    
    @ViewBuilder
    private func buttonIcon(resource: ImageResource) -> some View {
        Image(resource)
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(foreground.style)
    }
    
    @ViewBuilder
    private func buttonStyle<Content: View>(content: Content) -> some View {
        switch style {
        case .bordered(let radius, let border):
            content
                .overlay {
                    RoundedRectangle(cornerRadius: radius)
                        .strokeBorder(background.style, lineWidth: border)
                }
        case .filled(let radius):
            content
                .background {
                    RoundedRectangle(cornerRadius: radius)
                        .fill(background.style)
                }
        case .none:
            content
        }
    }
    
    @ViewBuilder
    private func buttonFrame<Content: View>(content: Content) -> some View {
        switch frame {
        case .height(let height, let maxWidth):
            content
                .frame(height: height)
                .frame(maxWidth: maxWidth)
        case .rect(let width, let height, let maxWidth):
            content
                .frame(width: width, height: height)
                .frame(maxWidth: maxWidth)
        case .none:
            content
        }
    }
    
}

#Preview {
    ButtonView(
        type: .iconText(.arrowback, .string("Continue")),
        foreground: ColorStyle.color(.red),
        background: ColorStyle.linearGraident(Color.main),
        style: .filled(radius: 20)) {
            print("Tapped")
        }
}
