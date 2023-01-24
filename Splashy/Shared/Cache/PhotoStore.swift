
import Combine

final class PhotoStore: ObservableObject {
    @Published var photos: [Photo] = []
    
    func contains(_ photo: Photo) -> Bool {
        photos.contains(photo)
    }
    
    func toggle(_ photo: Photo) {
        if photos.contains(photo) {
            remove(photo)
        } else {
            add(photo)
        }
    }
    
    private func add(_ photo: Photo) {
        photos.append(photo)
    }
    
    private func remove(_ photo: Photo) {
        if let index = photos.firstIndex(of: photo) {
            photos.remove(at: index)
        }
    }
}
