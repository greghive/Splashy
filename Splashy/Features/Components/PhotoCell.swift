
import SwiftUI

struct PhotoCell: View {
    let photo: Photo
    
    var body: some View {
        PhotoImage(url: photo.url)
            .background(.white)
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct PhotoCell_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCell(photo: .stubs[0])
            .previewLayout(.sizeThatFits)
    }
}

