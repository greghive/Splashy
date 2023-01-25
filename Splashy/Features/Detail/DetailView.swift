
import SwiftUI

struct DetailView: View {
    let model: DetailModel
    @ObservedObject var favs: PhotoStore
        
    var body: some View {
        VStack {
            PhotoImage(url: model.photoUrl)
            HStack(spacing: 12) {
                UserImage(url: model.profileUrl)
                    .frame(width: 30, height: 30)
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
                Spacer()
                Button {
                    favs.toggle(model.photo)
                } label: {
                    Image(systemName: "star.circle.fill")
                        .resizable()
                        .foregroundColor(favs.contains(model.photo) ? .blue : .gray)
                }
                .frame(width: 30, height: 30)
            }
            .ignoresSafeArea()
            .background(.white)
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        }
    }
}
