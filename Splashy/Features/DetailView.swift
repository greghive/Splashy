
import SwiftUI

struct DetailView: View {
    let photo: Photo
    @EnvironmentObject var model: SplashyModel
        
    var body: some View {
        VStack {
            PhotoImage(url: photo.url)
            HStack(spacing: 12) {
                UserImage(url: photo.profileUrl)
                    .frame(width: 30, height: 30)
                VStack(alignment: .leading, spacing: 2) {
                    Text(photo.username)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    Text(photo.text)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                Spacer()
                Button {
                    model.favs.toggle(photo)
                } label: {
                    Image(systemName: "star.circle.fill")
                        .resizable()
                        .foregroundColor(model.favs.contains(photo) ? .blue : .gray)
                }
                .frame(width: 30, height: 30)
            }
            .ignoresSafeArea()
            .background(.white)
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(photo: .stubs[0])
            .environmentObject(SplashyModel())
    }
}
