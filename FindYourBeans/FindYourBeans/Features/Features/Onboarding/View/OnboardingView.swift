import SwiftUI
import Combine

struct OnboardingView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State private var currentIndex: Int = 0
    private let viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            headerView
            onboardingCards
            continueButton
            Spacer()
        }
        .withBackgroundColor()
    }
    
    // Top: Logo and App Title
    private var headerView: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Spacer()
                Image(.appLogoBg)
                    .resizable()
                    .frame(width: 150, height: 150)
                VStack {
                    title
                }
                Spacer()
            }
        }
    }
    
    private var title: some View {
        VStack {
            Text("FIND")
            Text("YOUR")
            Text("BEANS")
        }
        .font(.custom("Impact", size: 30))
        .foregroundColor(Color.appGreen)
    }
    
    // Card Carousel
    private var onboardingCards: some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(viewModel.cards.enumerated()), id: \ .element.id) { index, card in
                VStack(spacing: 0) {
                    VStack {
                        VStack(spacing: 20) {
                            card.image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .foregroundColor(.gray.opacity(0.5))
                            Text(card.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(card.description)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(radius: 8)
                    }
                }
                .padding(.horizontal, 24)
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
    
    // Next/Let's Start Button
    private var continueButton: some View {
        Button(action: {
            if currentIndex < viewModel.cards.count - 1 {
                withAnimation { currentIndex += 1 }
            } else {
                coordinator.navigate(to: .home) // Or .home if you have a HomeView
            }
        }) {
            Text(currentIndex == viewModel.cards.count - 1 ? "Let's Start" : "Next")
                .font(style: .title3Medium)
                .foregroundColor(.appWhite)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.appGreen)
                .cornerRadius(16)
                .padding(.horizontal, 32)
        }
    }
}

struct OnboardingViewModel {
    
    let cards: [OnboardingCard] = [
        OnboardingCard(image: Image(.onboarding1),
                       title: "Discover Local Cafés",
                       description: "Find the best coffee spots near you, curated by coffee lovers for coffee lovers."),
        OnboardingCard(image: Image(.onboarding2),
                       title: "Track Your Beans",
                       description: "Keep a log of your favorite beans and never forget what you loved."),
        OnboardingCard(image:Image(.onboarding3),
                       title: "Share & Connect",
                       description: "Invite friends, share your finds, and grow your coffee community.")
    ]
    
    struct OnboardingCard: Identifiable {
        let id = UUID()
        let image: Image
        let title: String
        let description: String
    }
}

#Preview {
    OnboardingView().environmentObject(Coordinator())
}
