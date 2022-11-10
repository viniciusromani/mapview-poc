import SwiftUI

/**
 TODO: SelectableRow could be an isolated component
 */
struct LocationRowView: View {
    private(set) var model: LocationModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.model.title)
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
        LocationRowView(
            model:
                LocationModel(title: "Piracicaba - SP Brazil",
                              latitude: 0,
                              longitude: 0
                             ))
        .background(Color.gray.opacity(0.3)) // This is only to check padding
    }
}
