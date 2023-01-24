
import SwiftUI

struct FavsView: View {
    @ObservedObject private(set) var model: FavsModel

    var body: some View {
        PhotoGrid(photos: model.favs.photos, numColumns: 3) {
            model.selectedPhoto = $0
        }
        .sheet(item: $model.selectedPhoto) {
            DetailView(model: DetailModel(photo: $0), favs: model.favs)
        }
    }
}
