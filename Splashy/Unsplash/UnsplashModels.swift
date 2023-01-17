
struct SearchResponse: Decodable {
    let results: [Photo]
}

struct Photo: Hashable, Decodable, Identifiable {
    let id: String
    let urls: PhotoUrls
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
