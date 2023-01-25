
import Combine

final class FavsModel: ObservableObject {
    @Published var favs: PhotoStore
    @Published var selectedPhoto: Photo?
    
    var hasFavs: Bool {
        favs.photos.count > 0
    }
    
    init(favs: PhotoStore) {
        self.favs = favs
        self.selectedPhoto = nil
    }
}
