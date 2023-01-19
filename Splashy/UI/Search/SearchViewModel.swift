
import Foundation
import Combine

extension SearchView {
    class ViewModel: ObservableObject {
        @Published var searchTerm = ""
        @Published var searchState = State.idle
        
        enum State {
            case idle
            case success([Photo])
            case failure(String)
        }
        
        init() {
            $searchTerm
                .dropFirst()
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
                .map(searchPhotos)
                .switchToLatest()
                .catch(errorHandler)
                .assign(to: &$searchState)
        }
        
        private func searchPhotos(string: String) -> AnyPublisher<State, Error> {
            unsplash.call(.searchPhotos(query: string, perPage: 21))
                .map(\SearchResponse.results)
                .map { .success($0) }
                .eraseToAnyPublisher()
        }
        
        private func errorHandler(error: Error) -> AnyPublisher<State, Never> {
            Just(.failure(error.message))
                .eraseToAnyPublisher()
        }
    }
}

