
import SwiftUI

struct SearchRow: View {
    let viewModel: ViewModel
    var body: some View {
        AsyncImage(url: viewModel.url)
            .frame(width: 200, height: 200)
    }
}
