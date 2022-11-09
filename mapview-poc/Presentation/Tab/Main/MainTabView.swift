import SwiftUI

struct MainTabView: View {
    @StateObject
    private var viewModel = MainTabViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selected) {
            MapTabView()
                .tag(Screen.map)
                .tabItem {
                    Image(systemName: "map")
                }
            ProfileTabView()
                .tag(Screen.profile)
                .tabItem {
                    Image(systemName: "person.circle.fill")
                }
        }
        .highPriorityGesture(
            DragGesture().onEnded { value in
                self.viewModel.handleSwipe(value.translation.width)
            }
        )
        .navigationBarTitle("MapApp")
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
