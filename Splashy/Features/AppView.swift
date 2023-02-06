
import SwiftUI

enum Tab {
    case search
    case favs
}

struct AppView: View {
    @State var selectedTab: Tab = .search
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SearchView()
                .tabItem { Label("Search", systemImage: "magnifyingglass.circle.fill") }
                .tag(Tab.search)
            FavsView()
                .tabItem { Label("Favs", systemImage: "star.circle.fill") }
                .tag(Tab.favs)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(SplashyModel())
    }
}
