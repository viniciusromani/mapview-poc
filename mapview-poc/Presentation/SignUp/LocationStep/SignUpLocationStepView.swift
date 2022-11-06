import SwiftUI

struct SignUpLocationStepView: View {
    @EnvironmentObject private var coordinator: Coordinator<SignUpRouter>
    @ObservedObject private var viewModel: SignUpLocationStepViewModel
    
    init(viewModel: SignUpLocationStepViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Where are you from?")
                .font(.largeTitle)
                .fontWeight(.bold)
            TextField("Enter location here", text: $viewModel.location)
                .textFieldStyle(RoundedTextFieldStyle())
                .padding(.vertical, 16)
            Button("Done") {
                print("Button Clicked")
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(viewModel.canSubmit.negated)
        }
        .padding()
        .navigationBarTitle("MapApp")
    }
}

struct SignUpLocationStepView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpLocationStepView(
            viewModel: SignUpLocationStepViewModel(
                name: "Vinicius Romani"
            )
        ).previewDisplayName("Empty")
        
        SignUpLocationStepView(
            viewModel: SignUpLocationStepViewModel(
                name: "Vinicius Romani",
                location: "Piracicaba, SP"
            )
        ).previewDisplayName("Filled")
    }
}
