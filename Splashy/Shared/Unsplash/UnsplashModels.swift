
//MARK: - Search API Response

struct SearchResponse: Codable {
    let results: [Photo]
}

//MARK: - Photo API Model

struct Photo: Hashable, Codable, Identifiable {
    let id: String
    let description: String?
    let urls: PhotoUrls
    let user: User
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
}

import Foundation
extension Photo {
    var url: URL? {
        URL(string: urls.full)
    }
}

//MARK: - Photo URLs API Model

struct PhotoUrls: Hashable, Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

extension PhotoUrls: Equatable {
    static func == (lhs: PhotoUrls, rhs: PhotoUrls) -> Bool {
        lhs.raw == rhs.raw
    }
}

//MARK: - User API Model

struct User: Codable, Hashable {
    let id: String
    let name: String
    let profileImage: ProfileImage
}

struct ProfileImage: Codable, Hashable {
    let small: String
    let medium: String
    let large: String
}
