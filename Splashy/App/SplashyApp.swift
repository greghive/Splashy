
import SwiftUI

//TODO: PhotoView (detail screen)
//TODO: Add TabBar to root
//TODO: FavsView
//TODO: Favs persistence
//TODO: Toggle fav status from detail screen

@main
struct SplashyApp: App {
    var body: some Scene {
        WindowGroup {
            PhotoSearchView(model: .init())
        }
    }
}
