
import Foundation

extension SearchRow {
    struct ViewModel {
        let photo: Photo
        var url: URL? {
            URL(string: photo.urls.thumb)
        }
    }
}
