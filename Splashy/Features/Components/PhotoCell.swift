
import SwiftUI

//MARK: - Model

struct PhotoCellModel {
    let photo: Photo
    
    var url: URL? {
        URL(string: photo.urls.thumb)
    }
}

//MARK: - View

struct PhotoCell: View {
    let model: PhotoCellModel
    
    var body: some View {
        PhotoImage(url: model.url)
            .background(.white)
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

