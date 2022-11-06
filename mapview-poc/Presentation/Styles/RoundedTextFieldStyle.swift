import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(16)
    }
}

struct RoundedTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Type something...", text: .constant(""))
            .textFieldStyle(RoundedTextFieldStyle())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
