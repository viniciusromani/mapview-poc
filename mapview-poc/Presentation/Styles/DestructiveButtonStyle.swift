import SwiftUI

struct DestructiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(16)
    }
}

struct DestructiveButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Logout") {
            print("Button Clicked")
        }.buttonStyle(DestructiveButtonStyle())
        .padding()
        .previewDisplayName("Enabled")
        
        Button("Logout") {
            print("Button Clicked")
        }.buttonStyle(DestructiveButtonStyle())
        .padding()
        .disabled(true)
        .previewDisplayName("Disabled")
    }
}
