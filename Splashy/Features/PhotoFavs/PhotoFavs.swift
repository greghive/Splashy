
import SwiftUI

final class PhotoFavsModel: ObservableObject{
    
}

struct PhotoFavsView: View {
    let model: PhotoFavsModel
    
    var body: some View {
        Text("Hello, Favs!")
    }
}

struct PhotoFavsView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoFavsView(model: .init())
    }
}
