import SwiftUI

struct SplashView: View {
    @EnvironmentObject
    private var coordinator: SplashCoordinator
    
    @StateObject
    private var viewModel = SplashViewModel()
    
    var body: some View {
        ZStack {
            LoadableView()
        }
        .background(Color.white)
        .onAppear {
            Task {
                let user = await viewModel.getUser()
                coordinator.didFinishSplash(user: user)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
