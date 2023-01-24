
import SwiftUI

//MARK: - Model

struct PhotoDetailModel {
    let photo: Photo

    var photoUrl: URL? {
        URL(string: photo.urls.full)
    }
    
    var profileUrl: URL? {
        URL(string: photo.user.profileImage.medium)
    }
    
    var username: String {
        photo.user.name
    }
    
    var description: String {
        photo.description ?? "This image has no description"
    }
}

//MARK: - View

struct PhotoDetailView: View {
    let model: PhotoDetailModel
    @ObservedObject var favs: PhotoStore
    
    var body: some View {
        VStack {
            PhotoImage(url: model.photoUrl)
            PhotoCard(model: model, favs: favs)
        }
    }
}

//MARK: - View Components

struct PhotoCard: View {
    let model: PhotoDetailModel
    @ObservedObject var favs: PhotoStore
    
    var body: some View {
        HStack(spacing: 12) {
            UserImage(url: model.profileUrl)
                .frame(width: 30, height: 30)
            PhotoText(model: model)
            Spacer()
            FavsButton(model: model, favs: favs)
                .frame(width: 30, height: 30)
        }
        .ignoresSafeArea()
        .background(.white)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
    }
}

struct PhotoText: View {
    let model: PhotoDetailModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(model.username)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .lineLimit(1)
            Text(model.description)
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.gray)
                .lineLimit(1)
        }
    }
}

struct FavsButton: View {
    let model: PhotoDetailModel
    @ObservedObject var favs: PhotoStore
    
    var body: some View {
        Button {
            favs.toggle(model.photo)
        } label: {
            Image(systemName: "star.circle.fill")
                .resizable()
                .foregroundColor(favs.contains(model.photo) ? .blue : .gray)
        }
    }
}
