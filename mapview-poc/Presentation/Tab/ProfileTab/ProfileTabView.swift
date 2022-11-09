import SwiftUI

struct ProfileTabView: View {
    @StateObject
    private var viewModel = ProfileTabViewModel()
    
    var body: some View {
        VStack {
            if let user = viewModel.user {
                VStack(alignment: .leading, spacing: 8) {
                    Text("YOUR PROFILE")
                        .font(.caption.bold())
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 16)
                    Text("Name: \(user.name)")
                        .font(.title.bold())
                    Text("Location: \(user.location)")
                        .font(.title.bold())
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .onAppear { self.viewModel.getUser() }
        .alert(isPresented: Binding(get: {
            viewModel.user == nil
        }, set: { _ in })) {
            Alert(
                title: Text("No user was found"),
                message: Text("Please reinstall the app and fill up the onboarding"),
                dismissButton: .default(Text("Got it!")))
        }
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabView()
    }
}
