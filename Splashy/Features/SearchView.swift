
import SwiftUI

struct SearchView: View {
    @State var selectedPhoto: Photo?
    @EnvironmentObject var model: SplashyModel

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
                selectedPhoto = $0
            }
            .sheet(item: $selectedPhoto) {
                DetailView(photo: $0)
            }
            
        case .failure(let message):
            MessageText(message: message)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SplashyModel())
    }
}




