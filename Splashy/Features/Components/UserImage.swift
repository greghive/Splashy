
import SwiftUI

struct UserImage: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) {
            $0.resizable()
        } placeholder: {
            Image(systemName: "person")
        }
        .frame(width: 30, height: 30)
        .background(.gray)
        .foregroundColor(.white)
        .clipShape(Circle())
    }
}
