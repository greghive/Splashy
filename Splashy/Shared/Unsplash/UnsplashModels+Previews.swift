
import Foundation

extension Photo {
    static func preview(url: String) -> Photo {
        Photo(
            id: UUID().uuidString,
            description: "This is a preview photo",
            urls: .preview(url: url),
            user: .preview)
    }
    
    static func previews(urls: [String]) -> [Photo] {
        urls.map { Photo.preview(url: $0) }
    }
}

extension PhotoUrls {
    static func preview(url: String) -> PhotoUrls {
        PhotoUrls(
            raw: url,
            full: url,
            regular: url,
            small: url,
            thumb: url
        )
    }
}

extension User {
    static var preview: User {
        User(
            id: "1",
            name: "Awesome User",
            profileImage: .preview
        )
    }
}

extension ProfileImage {
    static var preview: ProfileImage {
        ProfileImage(
            small: "https://bit.ly/3Hbs7Hj",
            medium: "https://bit.ly/3Hbs7Hj",
            large: "https://bit.ly/3Hbs7Hj"
        )
    }
}
