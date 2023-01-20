
import SwiftUI

//MARK: - Model

struct PhotoDetailModel {
    let photo: Photo
    var url: URL? {
        URL(string: photo.urls.full)
    }
}

//MARK: - View

struct PhotoDetailView: View {
    let model: PhotoDetailModel
    
    var body: some View {
        PhotoImage(url: model.url)
            .background(.white)
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
    }
}

//struct PhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoView()
//    }
//}
