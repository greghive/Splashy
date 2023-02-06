
import SwiftUI

@main
struct SplashyApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(SplashyModel())
        }
    }
}
