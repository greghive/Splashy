
import SwiftUI

//MARK: - Model

final class AppModel: ObservableObject {
    @Published var selectedTab: Tab = .search
    @Published var favs: PhotoStore = PhotoStore()
    
    enum Tab {
        case search
        case favs
    }
}

//MARK: - View

struct AppView: View {
    @StateObject var model: AppModel
    
    var body: some View {
        TabView(selection: $model.selectedTab) {
            
            PhotoSearchView(model: PhotoSearchModel(favs: model.favs))
                .tabItem { Label("Search", systemImage: "magnifyingglass.circle.fill") }
                .tag(AppModel.Tab.search)
            
            PhotoFavsView(model: PhotoFavsModel(favs: model.favs))
                .tabItem { Label("Favs", systemImage: "star.circle.fill") }
                .tag(AppModel.Tab.favs)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(model: .init())
    }
}
