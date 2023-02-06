
import SwiftUI

struct FavsView: View {
    @State var selectedPhoto: Photo?
    @EnvironmentObject var model: SplashyModel

    var body: some View {
        NavigationStack {
            content
            .navigationTitle("Favs")
        }
    }
    
    @ViewBuilder private var content: some View {
        if model.hasFavs {
            PhotoGrid(photos: model.favs.photos, numColumns: 3) {
                selectedPhoto = $0
            }
            .sheet(item: $selectedPhoto) {
                DetailView(photo: $0)
            }
        } else {
            MessageText(message: "Your favs will appear here")
        }
    }
}

struct FavsView_Previews: PreviewProvider {
    static var previews: some View {
        FavsView()
            .previewDisplayName("Favs Data")
            .environmentObject(SplashyModel(favs: .preview))
        FavsView()
            .previewDisplayName("Favs Empty")
            .environmentObject(SplashyModel(favs: .empty))
    }
}
