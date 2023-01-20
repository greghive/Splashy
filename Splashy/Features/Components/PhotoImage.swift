
import SwiftUI

struct PhotoImage: View {
    let url: URL?
    
    var body: some View {
        GeometryReader { geo in
            AsyncImage(url: url) { phase in
                switch phase {

                case .empty:
                    ProgressView()
                        .position(x: geo.size.width / 2, y: geo.size.height / 2)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure:
                    Image(systemName: "exclamationmark.icloud")
                        .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        .foregroundColor(.gray)

                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}
