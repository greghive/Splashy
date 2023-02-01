
import SwiftUI

struct AppView: View {
    @StateObject var model: AppModel
    
    var body: some View {
        TabView(selection: $model.selectedTab) {
            
            SearchView(model: SearchModel(api: unsplash, favs: model.favs))
                .tabItem { Label("Search", systemImage: "magnifyingglass.circle.fill") }
                .tag(AppModel.Tab.search)
            
            FavsView(model: FavsModel(favs: model.favs))
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
