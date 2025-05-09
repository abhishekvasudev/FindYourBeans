import SwiftUI

struct SplashView: View {
    
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        ZStack {
            background
            mainContent
        }
        .onAppear(delay: 2.0) {
//            coordinator.navigate(to: .onboarding)
        }
        .navigationDestination(
            path: $coordinator.path,
            navigationBar: .hidden,
            NavigationDestination.self)
        .environmentObject(coordinator)
    }
    
    private var background: some View {
        ColorView(colorStyle: .linearGraident(Color.main))
            .ignoresSafeArea()
    }
    
    private var mainContent: some View {
        VStack(spacing: Padding.thirty) {
            Spacer()
            Image(.appLogoBg)
                .shadow(color: Color.white.opacity(0.6), radius: 15, x: 0, y: 0)
            title
            Spacer()
            footer
        }
    }
    
    private var title: some View {
        VStack {
            Text("FIND")
            Text("YOUR")
            Text("BEANS")
        }
        .font(.custom("Impact", size: 70))
        .foregroundColor(Color.appGreen)
    }
    
    private var footer: some View {
        TextView(
            text: .string("All Beans, No Fuss"),
            fontStyle: .bodyRegular,
            foreground: ColorStyle.color(.soldOutRed)
        )
        .padding(.bottom, Padding.twenty)
    }
    
}

#Preview {
    SplashView()
}
