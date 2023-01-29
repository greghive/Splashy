
import Combine
import Foundation

final class PhotoStore: ObservableObject {
    private let cacheKey: String
    private let storage: CodableStorage
    
    @Published private(set) var photos: [Photo] = []
    
    init(cacheKey: String) {
        self.cacheKey = cacheKey
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let disk = FileStorage(url: paths[0])
        self.storage = CodableStorage(storage: disk, decoder: unsplashDecoder, encoder: unsplashEncoder)
        self.photos = readFromDisk()
    }
    
    func contains(_ photo: Photo) -> Bool {
        photos.contains(photo)
    }
    
    func toggle(_ photo: Photo) {
        if contains(photo) {
            remove(photo)
        } else {
            add(photo)
        }
    }
    
    func clear() {
        photos = []
        writeToDisk()
    }
    
    private func add(_ photo: Photo) {
        photos.append(photo)
        writeToDisk()
    }
    
    private func remove(_ photo: Photo) {
        if let index = photos.firstIndex(of: photo) {
            photos.remove(at: index)
            writeToDisk()
        }
    }
    
    private func readFromDisk() -> [Photo] {
        do {
            return try storage.read(for: cacheKey)
        } catch {
            return []
        }
    }
    
    private func writeToDisk() {
        try? storage.write(photos, for: cacheKey)
    }
}

extension PhotoStore {
    static var preview: PhotoStore {
        let store = PhotoStore(cacheKey: "photo_store_preview")
        store.photos = Photo.mocks
        return store
    }
    
    static var empty: PhotoStore {
        PhotoStore(cacheKey: UUID().uuidString)
    }
}
