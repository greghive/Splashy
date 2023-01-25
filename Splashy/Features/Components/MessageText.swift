
import SwiftUI

struct MessageText: View {
    let message: String
    
    var body: some View {
        Text(message)
            .multilineTextAlignment(.center)
            .foregroundColor(.gray)
            .padding()
    }
}

struct MessageText_Previews: PreviewProvider {
    static var previews: some View {
        MessageText(message: "Your favs will appear here")
    }
}
