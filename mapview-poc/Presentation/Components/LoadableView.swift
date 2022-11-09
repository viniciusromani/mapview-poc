import SwiftUI

enum LoadableState {
    case initial
    case loading
    case loaded
    case error
    
    var isLoading: Bool { self == .loading }
}

struct LoadableView: View {
    var body: some View {
        ZStack {
            Color(UIColor.clear)
            ProgressView()
        }
    }
}

struct LoadableView_Previews: PreviewProvider {
    static var previews: some View {
        LoadableView()
    }
}
