import SwiftUI

struct SignUpNameStepView: View {
    @EnvironmentObject
    private var coordinator: SignUpCoordinator
    
    @ObservedObject
    private var viewModel: SignUpNameStepViewModel
    
    init(viewModel: SignUpNameStepViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What is your name?")
                .font(.largeTitle)
                .fontWeight(.bold)
            TextField("Enter name here", text: $viewModel.name)
                .textFieldStyle(RoundedTextFieldStyle())
                .padding(.vertical, 16)
            Button("Next") {
                self.coordinator.didFinishName(self.viewModel.name)
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(viewModel.canSubmit.negated)
        }
        .ignoresSafeArea()
        .padding()
        .navigationBarTitle("MapApp", displayMode: .inline)
    }
}

struct SignUpNameStepView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNameStepView(
            viewModel: SignUpNameStepViewModel()
        ).previewDisplayName("Empty")
        
        SignUpNameStepView(
            viewModel: SignUpNameStepViewModel(name: "Vinicius Romani")
        ).previewDisplayName("Filled")
    }
}
