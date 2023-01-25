
import SwiftUI

//TODO: Improve previews with static data

@main
struct SplashyApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(model: AppModel())
        }
    }
}
