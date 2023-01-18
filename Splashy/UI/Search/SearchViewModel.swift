
import Foundation
import Combine

extension SearchView {
    class ViewModel: ObservableObject {
        @Published var searchTerm = ""
        @Published var searchResults = [Photo]()
        
        init() {
            $searchTerm
                .debounce(for: .seconds(0.3), scheduler: DispatchQueue.global())
                .map { unsplash.call(.searchPhotos(query: $0, perPage: 21)).map(\SearchResponse.results) }
                .switchToLatest()
                .replaceError(with: [Photo]())
                .assign(to: &$searchResults)
        }
    }
}
