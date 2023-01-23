
struct SearchResponse: Decodable {
    let results: [Photo]
}

struct Photo: Hashable, Decodable, Identifiable {
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

struct PhotoUrls: Hashable, Decodable {
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

struct User: Decodable, Hashable {
    let id: String
    let name: String
    let profileImage: ProfileImage
}

struct ProfileImage: Decodable, Hashable {
    let small: String
    let medium: String
    let large: String
}
