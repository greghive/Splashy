
import SwiftUI
import Combine

//MARK: - Model

final class PhotoSearchModel: ObservableObject {
    @Published var searchTerm = ""
    @Published var searchState = SearchState.idle
    @Published var selectedPhoto: Photo?
    @Published var favs: PhotoStore
    
    enum SearchState {
        case idle
        case success([Photo])
        case failure(String)
    }
    
    init(favs: PhotoStore) {
        self.favs = favs
        
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .map(searchPhotos)
            .switchToLatest()
            .catch(handleError)
            .assign(to: &$searchState)
    }
    
    private func searchPhotos(string: String) -> AnyPublisher<SearchState, Error> {
        unsplash.call(.searchPhotos(query: string, perPage: 21))
            .map(\SearchResponse.results)
            .map { .success($0) }
            .eraseToAnyPublisher()
    }
    
    private func handleError(error: Error) -> AnyPublisher<SearchState, Never> {
        Just(.failure(error.message))
            .eraseToAnyPublisher()
    }
}

//MARK: - View

struct PhotoSearchView: View {
    @ObservedObject private(set) var model: PhotoSearchModel

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Splashy")
                .searchable(text: $model.searchTerm)
        }
    }
    
    @ViewBuilder private var content: some View {
        switch model.searchState {

        case .idle:
            EmptyView()
        
        case .success(let photos):
            PhotoGrid(photos: photos, numColumns: 3) {
                model.selectedPhoto = $0
            }
            .sheet(item: $model.selectedPhoto) {
                PhotoDetailView(model: PhotoDetailModel(photo: $0), favs: model.favs)
            }
            
        case .failure(let message):
            Text(message)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct PhotoSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSearchView(model: PhotoSearchModel(favs: PhotoStore()))
    }
}




