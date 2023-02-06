
import Foundation
@testable import Splashy

enum SearchPhotosSuccessResponder: MockURLResponder {
    static func respond(to request: URLRequest) throws -> Data {
        try unsplashEncoder.encode(SearchResponse.stub)
    }
}

enum SearchPhotosInvalidURLResponder: MockURLResponder {
    static func respond(to request: URLRequest) throws -> Data {
        throw APIError.invalidUrl
    }
}
