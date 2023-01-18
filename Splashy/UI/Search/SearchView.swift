
import SwiftUI

struct SearchView: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Splashy")
                .searchable(text: $viewModel.searchTerm)
        }
    }
    
    @ViewBuilder private var content: some View {
        switch viewModel.searchState {

        case .idle:
            EmptyView()
        
        case .success(let photos):
            PhotoGrid(photos: photos, numColumns: 3)
        
        case .error(_):
            EmptyView()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: .init())
    }
}


