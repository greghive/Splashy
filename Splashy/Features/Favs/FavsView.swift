
import SwiftUI

struct FavsView: View {
    @ObservedObject private(set) var model: FavsModel

    var body: some View {
        NavigationStack {
            PhotoGrid(photos: model.favs.photos, numColumns: 3) {
                model.selectedPhoto = $0
            }
            .navigationTitle("Favs")
            .sheet(item: $model.selectedPhoto) {
                DetailView(model: DetailModel(photo: $0), favs: model.favs)
            }
        }
    }
}
