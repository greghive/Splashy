
import Foundation
import Combine

// search unsplash using the search term
// assign the result to be reflected in the UI
// come back to more complex solitions
// (we don't need that knowledge yet)

extension SearchView {
    class ViewModel: ObservableObject {
        @Published var searchTerm = ""
        @Published var searchResults = [String]()
        
        // how to make the request as the search term changes?
        // debounced
        // and then populate the list (locally vs app state)
        // using assign to??
        // and then how to change view state (loading / loaded / error etc)
        
        //private let unsplash = API(session: .shared)
        //private var subscriptions = Set<AnyCancellable>()
        
        init() {
            $searchTerm
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
                .flatMap { unsplash.call(.searchPhotos(query: $0)) }
                .replaceError(with: [])
                .assign(to: &$searchResults)
            
            // handle errors (mapped to unsplash specifics) and show state changes
            // 1. empty data UI
            // 2. loading UI
            // 3. error UI
        }
    }
}

// then need to tackle navigation
