import SwiftUI

public struct DividerView: View {
    public var body: some View {
        Divider()
            .overlay(Color.gray.opacity(0.5))
            .padding(.horizontal)
            .padding(.bottom, 8)
    }
}
