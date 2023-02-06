
import Foundation

extension SearchResponse {
    static var stub: SearchResponse {
        Bundle.main.decode("search_response.json", with: unsplashDecoder)
    }
}

extension Photo {
    static var stubs: [Photo] {
        SearchResponse.stub.results
    }
}
