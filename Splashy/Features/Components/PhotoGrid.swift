
import SwiftUI

struct PhotoGrid: View {
    let photos: [Photo]
    let numColumns: Int
    var selection: (Photo) -> Void 
    
    var body: some View {
        let spacing: CGFloat = 10
        let columms = [GridItem](repeatElement(GridItem(.flexible()), count: numColumns))
        
        ScrollView {
            LazyVGrid(columns: columms, spacing: spacing, content: {
                ForEach(photos) { photo in
                    Button {
                        selection(photo)
                    } label: {
                        PhotoCell(photo: photo)
                    }
                }
            })
            .padding(spacing)
            .listStyle(.plain)
        }
    }
}

struct PhotoGrid_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGrid(photos: Photo.stubs, numColumns: 3, selection: { _ in })
    }
}
