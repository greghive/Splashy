
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

struct PhotoModel {
    let photo: Photo

    var url: URL? {
        URL(string: photo.urls.full)
    }
    
    var profileUrl: URL? {
        URL(string: photo.user.profileImage.medium)
    }
    
    var username: String {
        photo.user.name
    }
    
    var description: String {
        photo.description ?? "This image has no description"
    }
}

extension SplashyModel.SearchState: Equatable {
    public static func == (lhs: SplashyModel.SearchState, rhs: SplashyModel.SearchState) ->Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case let (.success(a), .success(b)):
            return a == b
        case let (.failure(a), .failure(b)):
            return a == b
        default:
            return false
        }
    }
}
