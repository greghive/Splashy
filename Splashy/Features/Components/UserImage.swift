
import SwiftUI

struct UserImage: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) {
            $0.resizable()
        } placeholder: {
            Image(systemName: "person.fill")
                .resizable()
        }
        .background(.gray)
        .foregroundColor(.white)
        .clipShape(Circle())
    }
}

struct UserImage_Previews: PreviewProvider {
    static var previews: some View {
        UserImage(url: URL(string: "https://bit.ly/3Hbs7Hj"))
            .padding()
            .previewLayout(.fixed(width: 80, height: 80))
    }
}
