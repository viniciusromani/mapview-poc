import SwiftUI

struct LocationRowView: View {
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.title)
                .lineLimit(2)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.all)
        }
        .frame(maxWidth: .infinity)
    }
}

struct LocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRowView(title: "Piracicaba, SP Brazil")
    }
}
