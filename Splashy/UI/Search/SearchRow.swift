
import SwiftUI

struct SearchRow: View {
    let viewModel: ViewModel
    
    var body: some View {
        PhotoImage(url: viewModel.url)
            .background(.white)
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
