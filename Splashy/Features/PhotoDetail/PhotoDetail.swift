
import SwiftUI

//MARK: - Model

struct PhotoDetailModel {
    let photo: Photo
    var url: URL? {
        URL(string: photo.urls.full)
    }
}

//MARK: - View

struct PhotoDetailView: View {
    let model: PhotoDetailModel
    
    var body: some View {
        PhotoImage(url: model.url)
            .background(.white)
            .ignoresSafeArea()
            .aspectRatio(1, contentMode: .fill)
    }
}
