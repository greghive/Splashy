
import Foundation

struct DetailModel {
    let photo: Photo

    var photoUrl: URL? {
        URL(string: photo.urls.full)
    }
    
    var profileUrl: URL? {
        URL(string: photo.user.profileImage.medium)
    }
    
    var username: String {
        photo.user.name
    }
    
    var description: String {
        photo.description ?? "This image has no description"
    }
}

extension DetailModel {
    static var preview: DetailModel {
        DetailModel(photo: .mocks[0])
    }
}
