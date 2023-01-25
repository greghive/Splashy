
import SwiftUI

struct FavsView: View {
    @ObservedObject private(set) var model: FavsModel

    var body: some View {
        NavigationStack {
            content
            .navigationTitle("Favs")
        }
    }
    
    @ViewBuilder private var content: some View {
        if model.hasFavs {
            PhotoGrid(photos: model.favs.photos, numColumns: 3) {
                model.selectedPhoto = $0
            }
            .sheet(item: $model.selectedPhoto) {
                DetailView(model: DetailModel(photo: $0), favs: model.favs)
            }
        } else {
            MessageText(message: "Your favs will appear here")
        }
    }
}

struct FavsView_Previews: PreviewProvider {
    static var previews: some View {
        FavsView(model: FavsModel(favs: PhotoStore(cacheKey: "preview_favs")))
    }
}
