import SwiftUI

struct SignUpLocationStepView: View {
    @EnvironmentObject
    private var coordinator: Coordinator<SignUpRouter>
    
    @ObservedObject
    private var viewModel: SignUpLocationStepViewModel
    
    init(viewModel: SignUpLocationStepViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Where are you from?")
                .font(.largeTitle)
                .fontWeight(.bold)
            TextField("Enter location here", text: $viewModel.typedLocation)
                .textFieldStyle(RoundedTextFieldStyle())
                .padding(.vertical, 16)
            List(viewModel.locationsFound) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                }
            }
            Button("Done") {
                Task {
                    await self.viewModel.search()
                }
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
                typedLocation: "Piracicaba, SP"
            )
        ).previewDisplayName("Filled")
    }
}
