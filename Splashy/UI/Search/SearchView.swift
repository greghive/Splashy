
import SwiftUI

struct SearchView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
//                ForEach(viewModel.searchResults, id: \.self) { name in
//                    NavigationLink {
//                        Text(name)
//                    } label: {
//                        Text(name)
//                    }
//                }
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
