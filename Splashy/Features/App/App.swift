
import SwiftUI

//MARK: - Model

final class AppModel: ObservableObject {
    enum Tab { case search; case favs }
    @Published var selectedTab: Tab = .search
}

//MARK: - View

struct AppView: View {
    @ObservedObject private(set) var model: AppModel
    
    var body: some View {
        TabView(selection: $model.selectedTab) {
            
            PhotoSearchView(model: .init())
                .tabItem { Label("Search", systemImage: "magnifyingglass.circle.fill") }
                .tag(AppModel.Tab.search)
            
            PhotoFavsView(model: .init())
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
