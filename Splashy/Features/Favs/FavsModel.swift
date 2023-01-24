
import Combine

final class FavsModel: ObservableObject {
    @Published var favs: PhotoStore
    @Published var selectedPhoto: Photo?
    
    init(favs: PhotoStore) {
        self.favs = favs
        self.selectedPhoto = nil
    }
}
