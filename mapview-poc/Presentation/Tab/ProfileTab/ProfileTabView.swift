import SwiftUI

struct ProfileTabView: View {
    @EnvironmentObject
    private var coordinator: TabCoordinator
    
    @StateObject
    var viewModel = ProfileTabViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("YOUR PROFILE")
                    .font(.caption.bold())
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)
                Text("Name: \(viewModel.user?.name ?? "-")")
                    .font(.title.bold())
                Text("Location: \(viewModel.user?.location.title ?? "-")")
                    .font(.title.bold())
                Spacer()
                Button("Logout") {
                    viewModel.logout()
                    coordinator.logout()
                }
                .buttonStyle(DestructiveButtonStyle())
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .onAppear { self.viewModel.getUser() }
        .alert(isPresented: Binding(viewModel.user == nil)) {
            Alert(
                title: Text("No user was found"),
                message: Text("Please reinstall the app and fill up the onboarding"),
                dismissButton: .default(Text("Got it!")))
        }
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static let filled: ProfileTabViewModel = {
        let _filled = ProfileTabViewModel()
        let location = LocationModel(
            title: "Piracicaba - SP, Brazil",
            latitude: -22.7292941,
            longitude: -47.6496458
        )
        _filled.user = UserModel(
            name: "Vinicius",
            location: location
        )
        return _filled
    }()
    static let noUser: ProfileTabViewModel = {
        let _noUser = ProfileTabViewModel()
        _noUser.user = nil
        return _noUser
    }()
    
    static var previews: some View {
        let _ = DataInjector()
        let _ = DomainInjector()
        
        ProfileTabView()
            .previewDisplayName("Empty")
        
        ProfileTabView(viewModel: filled)
            .previewDisplayName("Filled")
        
        ProfileTabView(viewModel: noUser)
            .previewDisplayName("No User")
    }
}
