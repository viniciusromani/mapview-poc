import SwiftUI

/**
 TODO: List row selection could be bindable
 */
struct SignUpLocationStepView: View {
    @EnvironmentObject
    private var coordinator: SignUpCoordinator
    
    @ObservedObject
    var viewModel = SignUpLocationStepViewModel(name: "")
    
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
    static let empty = SignUpLocationStepViewModel(name: "Vinicius")
    static let typed = SignUpLocationStepViewModel(
        name: "Vinicius",
        typedLocation: "Piracicaba"
    )
    static let loaded: SignUpLocationStepViewModel = {
        let _loaded = SignUpLocationStepViewModel(
            name: "Vinicius",
            typedLocation: "Piracicaba"
        )
        _loaded.state = .loaded
        _loaded.locationsFound = [
            LocationModel(title: "Piracicaba - SP, Brazil",
                          latitude: -22.7292941,
                          longitude: -47.6496458)]
        return _loaded
    }()
    static let error: SignUpLocationStepViewModel = {
        let _loaded = SignUpLocationStepViewModel(
            name: "Vinicius",
            typedLocation: "Piracicaba"
        )
        _loaded.state = .error
        _loaded.locationsFound = []
        return _loaded
    }()
    
    static var previews: some View {
        let _ = DataInjector()
        let _ = DomainInjector()
        
        SignUpLocationStepView(viewModel: empty)
            .previewDisplayName("Empty")
        
        SignUpLocationStepView(viewModel: typed)
            .previewDisplayName("Typed")
        
        SignUpLocationStepView(viewModel: loaded)
            .previewDisplayName("Found")
        
        SignUpLocationStepView(viewModel: error)
            .previewDisplayName("Error")
    }
}
