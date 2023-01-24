
import SwiftUI

struct UserImage: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) {
            $0.resizable()
        } placeholder: {
            Image(systemName: "person")
        }
        .background(.gray)
        .foregroundColor(.white)
        .clipShape(Circle())
    }
}
