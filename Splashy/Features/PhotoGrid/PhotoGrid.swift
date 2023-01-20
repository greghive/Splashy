
import SwiftUI

struct PhotoGrid: View {
    let photos: [Photo]
    let numColumns: Int
    
    var body: some View {
        let spacing: CGFloat = 10
        let columms = [GridItem](repeatElement(GridItem(.flexible()), count: numColumns))
        
        ScrollView {
            LazyVGrid(columns: columms, spacing: spacing, content: {
                ForEach(photos) {
                    PhotoCell(model: .init(photo: $0))
                }
            })
            .padding(spacing)
            .listStyle(.plain)
        }
    }
}

struct PhotoGrid_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGrid(photos: [], numColumns: 2)
    }
}
