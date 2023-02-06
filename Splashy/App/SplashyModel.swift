
import Combine
import Foundation

final class SplashyModel: ObservableObject {
    
    enum SearchState {
        case idle
        case success([Photo])
        case failure(String)
    }
    
    private let api: API
    @Published var searchTerm: String
    @Published private(set) var searchState: SearchState
    @Published var favs: PhotoStore
        
    var hasFavs: Bool {
        favs.photos.count > 0
    }
    
    init(api: API = unsplash, favs: PhotoStore = PhotoStore(cacheKey: "favs")) {
        self.api = api
        self.searchTerm = ""
        self.searchState = .idle
        self.favs = favs
                
        $searchTerm
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .map(searchPhotos)
            .switchToLatest()
            .catch(handleError)
            .assign(to: &$searchState)
    }
    
    private func searchPhotos(string: String) -> AnyPublisher<SearchState, Error> {
        api.call(.searchPhotos(query: string, perPage: 21))
            .map(\SearchResponse.results)
            .map { .success($0) }
            .eraseToAnyPublisher()
    }
    
    private func handleError(error: Error) -> AnyPublisher<SearchState, Never> {
        Just(.failure(error.message))
            .eraseToAnyPublisher()
    }
}
