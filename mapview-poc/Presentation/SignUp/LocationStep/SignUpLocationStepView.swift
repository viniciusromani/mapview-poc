import SwiftUI

/**
 TODO: List row selection could be bindable
 */
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
                     id: \.self) { location in
                    Section(header: Text("Locations Found")) {
                        LocationRowView(model: location)
                            .onTapGesture {
                                self.viewModel.store(location)
                                self.coordinator.didFinishSignUp()
                            }
                    }
                }.environment(\.editMode, .constant(.active))
            }
            Button {
                Task {
                    await viewModel.search()
                }
            } label: {
                ZStack {
                    let isLoading = viewModel.state.isLoading
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
        .ignoresSafeArea()
        .padding()
        .navigationBarTitle("MapApp")
        .alert(isPresented: Binding(viewModel.state == .error)) {
            Alert(
                title: Text("No results were found"),
                message: Text("Check typed city and your internet connection to try again"),
                dismissButton: .default(Text("Got it!")))
        }
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
