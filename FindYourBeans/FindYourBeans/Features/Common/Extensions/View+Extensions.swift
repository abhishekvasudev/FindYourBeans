import SwiftUI

//MARK: Navigation
extension View {
    
    func navigationDestination<D>(path: Binding<[D]>, navigationBar: Visibility, _ data: D.Type) -> some View where D: Hashable & View {
        NavigationStack(path: path) {
            self.navigationDestination(
                for: data,
                destination: {
                    $0.navigationBar(visibility: navigationBar)
                }
            )
        }
    }
    
}

//MARK: Fonts
extension View {
    
    func font(name: FontName = .inter, style: AppFontStyle) -> some View {
        return self.modifier(AppFont(name: name, style: style))
    }
    
}

//MARK: View
extension View {
    
    func onAppear(delay: TimeInterval, action: @escaping () -> Void) -> some View {
        task {
            do {
                let nano = UInt64(delay * 1_000_000_000)
                try await Task.sleep(nanoseconds: nano)
            } catch { // Task canceled
                return
            }
            await MainActor.run {
                action()
            }
        }
    }
    
    @ViewBuilder
    func isHidden(hidden: Bool) -> some View {
        switch hidden {
        case true: self.hidden()
        case false: self
        }
    }
    
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func contentView<Content: View>(content: (Self) -> Content) -> some View {
        content(self)
    }
    
    @ViewBuilder
    func navigationBar(visibility: Visibility) -> some View {
        self.toolbar(visibility, for: .navigationBar)
    }
    
    @ViewBuilder
    func withBackgroundColor() -> some View {
        self.modifier(BackgroundColor())
    }
    
}

struct BackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content.background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.splashScreen.opacity(1)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
        )
    }
}
