
import SwiftUI

struct ContentView: View {
    var body: some View {
        SearchView(viewModel: SearchView.ViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
