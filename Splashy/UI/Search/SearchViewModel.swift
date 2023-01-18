
import Foundation
import Combine

extension SearchView {
    class ViewModel: ObservableObject {
        @Published var searchTerm = ""
        @Published var searchState = State.idle
        
        enum State {
            case idle
            case success([Photo])
            case error(String)
        }
        
        init() {
            $searchTerm
                .debounce(for: .seconds(0.3), scheduler: DispatchQueue.global())
                .map { unsplash.call(.searchPhotos(query: $0, perPage: 21))
                    .map(\SearchResponse.results)
                    .map { .success($0) }
                }
                .switchToLatest()
                .mapError { $0 } // TODO: map to Unsplash domain error from APIError
                .catch { Just(.error($0.localizedDescription)) }
                .assign(to: &$searchState)
        }
    }
}
