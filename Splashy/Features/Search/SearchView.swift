
import SwiftUI

struct SearchView: View {
    @ObservedObject private(set) var model: SearchModel

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
                DetailView(model: DetailModel(photo: $0), favs: model.favs)
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
        SearchView(model: SearchModel(favs: PhotoStore()))
    }
}




