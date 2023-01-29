
import Foundation

extension SearchResponse {
    static var mock: SearchResponse {
        Bundle.main.decode("search_response.json", with: unsplashDecoder)
    }
}

extension Photo {
    static var mocks: [Photo] {
        SearchResponse.mock.results
    }
}
