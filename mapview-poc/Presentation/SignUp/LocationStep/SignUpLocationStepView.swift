import SwiftUI

struct SignUpLocationStepView: View {
    @EnvironmentObject
    private var coordinator: SignUpCoordinator
    
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
            if viewModel.state == .loaded {
                List(viewModel.locationsFound,
                     id: \.self,
                     selection: $viewModel.selectedLocation) { location in
                    Section(header: Text("Locations Found")) {
                        LocationRowView(title: location)
                    }
                }
            }
            Button {
                Task {
                    await self.viewModel.search()
                }
            } label: {
                ZStack {
                    let isLoading = self.viewModel.state.isLoading
                    Text("Search")
                        .opacity(isLoading ? 0: 1)
                    
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                    }
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
