
import Combine

final class AppModel: ObservableObject {
    @Published var selectedTab: Tab = .search
    @Published var favs: PhotoStore = PhotoStore(cacheKey: "favs")
    
    enum Tab {
        case search
        case favs
    }
}
