import SwiftUI

protocol ButtonColors {
    var foreground: Color { get }
    var background: Color { get }
}
private struct EnabledColors: ButtonColors {
    var foreground = Color.white
    var background = Color.accentColor
}
private struct DisabledColors: ButtonColors {
    var foreground = Color(red: 199 / 255, green: 199 / 255, blue: 204 / 255)
    var background = Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255)
}

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    private let enabledColors: ButtonColors
    private let disabledColors: ButtonColors
    
    init(enabledColors: ButtonColors = EnabledColors(),
         disabledColors: ButtonColors = DisabledColors()) {
        self.enabledColors = enabledColors
        self.disabledColors = disabledColors
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .foregroundColor(isEnabled ? enabledColors.foreground: disabledColors.foreground)
            .background(isEnabled ? enabledColors.background: disabledColors.background)
            .cornerRadius(16)
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Hit me!") {
            print("Button Clicked")
        }.buttonStyle(PrimaryButtonStyle())
        .padding()
        .previewDisplayName("Enabled")
        
        Button("Hit me!") {
            print("Button Clicked")
        }.buttonStyle(PrimaryButtonStyle())
        .padding()
        .disabled(true)
        .previewDisplayName("Disabled")
    }
}
