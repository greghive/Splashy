
import SwiftUI

//MARK: - Model

final class PhotoFavsModel: ObservableObject {
    @Published var favs: PhotoStore
    @Published var selectedPhoto: Photo?
    
    init(favs: PhotoStore) {
        self.favs = favs
        self.selectedPhoto = nil
    }
}

//MARK: - View

struct PhotoFavsView: View {
    @ObservedObject private(set) var model: PhotoFavsModel

    var body: some View {
        PhotoGrid(photos: model.favs.photos, numColumns: 3) {
            model.selectedPhoto = $0
        }
        .sheet(item: $model.selectedPhoto) {
            PhotoDetailView(model: PhotoDetailModel(photo: $0), favs: model.favs)
        }
    }
}
