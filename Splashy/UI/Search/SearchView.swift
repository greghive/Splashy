
import SwiftUI

struct SearchView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.searchResults) {
                SearchRow(viewModel: .init(photo: $0))
            }
            .navigationTitle("Splashy")
        }
        .searchable(text: $viewModel.searchTerm)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: .init())
    }
}


