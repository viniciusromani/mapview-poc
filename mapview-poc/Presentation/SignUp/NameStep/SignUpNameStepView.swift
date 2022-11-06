import SwiftUI

struct SignUpNameStepView: View {
    @EnvironmentObject private var coordinator: Coordinator<SignUpRouter>
    @ObservedObject private var viewModel: SignUpNameStepViewModel
    
    init(viewModel: SignUpNameStepViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What is your name?")
                .font(.largeTitle)
                .fontWeight(.bold)
            TextField("Type something...", text: $viewModel.name)
                .textFieldStyle(RoundedTextFieldStyle())
                .padding(.vertical, 16)
            Button("Hit me!") {
                print("Button Clicked")
            }.buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .navigationBarTitle("MapApp")
    }
}

struct SignUpNameStepView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNameStepView(viewModel: SignUpNameStepViewModel())
    }
}
