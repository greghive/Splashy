# Splashy

A SwiftUI project exploring design and architecture using Combine and the Unsplash API. Search for photos, view them full screen, and cache your favs to view later.

![UI Screenshot](https://user-images.githubusercontent.com/10616345/216593527-824789e3-bfa5-4aed-bf02-5077ec565378.jpg)

Through working on this simple demo, it was interesting to discover that MVVM is not a suitable architecture for SwiftUI apps, contrary to many samples and demos you will find. Rather, an MV style approach is much more satisfying. This app will be updated to further explore this in the coming days. For now, here is a list of some of the interesting things happening in this code base:

- The `searchable` view modifier. Search bar UI in a single line of code. 😎

```swift
var body: some View {
    NavigationStack {
        content
            .navigationTitle("Splashy")
            .searchable(text: $model.searchTerm)
    }
}
```

- Republishing values emitted by the search request to the `@Published` search state property using `assign(to:)` with internally managed subscription life cycle. Plus using `switchToLatest` to cancel debounced inflight search requests. 🤯  

```swift
@Published var searchTerm = ""
@Published var searchState = SearchState.idle

init(api: API, favs: PhotoStore) {
    self.api = api
    self.favs = favs

    $searchTerm
        .filter { !$0.isEmpty }
        .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
        .map(searchPhotos)
        .switchToLatest()
        .catch(handleError)
        .assign(to: &$searchState)
    }
```

- Combine error handling to convert a failing API request into an infallible publisher necessary for assigment to the `@Published` search state mentioned above. 🔥

```swift
enum SearchState {
    case idle
    case success([Photo])
    case failure(String)
}

private func handleError(error: Error) -> AnyPublisher<SearchState, Never> {
    Just(.failure(error.message))
        .eraseToAnyPublisher()
}
```

- iOS 16 SwiftUI Grid! 😁

```swift
struct PhotoGrid: View {
    let photos: [Photo]
    let numColumns: Int
    var selection: (Photo) -> Void

    var body: some View {
        let spacing: CGFloat = 10
        let columms = [GridItem](repeatElement(GridItem(.flexible()), count: numColumns))

        ScrollView {
            LazyVGrid(columns: columms, spacing: spacing, content: {
                ForEach(photos) { photo in
                    Button {
                        selection(photo)
                    } label: {
                        PhotoCell(model: .init(photo: photo))
                    }
                }
            })
            .padding(spacing)
            .listStyle(.plain)
        }
    }
}
```

- Reuseable Combine URLSession + Decodable publisher. 🚀

```swift
struct API {
    let session: URLSession
    func send<T: Decodable>(request: Request, decoder: JSONDecoder) -> AnyPublisher<T, Error> {
        do {
            return session.dataTaskPublisher(for: try request.build())
                .decodeData(decoder: decoder)
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}

fileprivate extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func tryData() -> AnyPublisher<Data, Error> {
        tryMap { result in
            guard let statusCode = (result.response as? HTTPURLResponse)?.statusCode else {
                throw APIError.unexpectedResponse
            }
            guard (200...299).contains(statusCode) else {
                throw APIError.failure(statusCode: statusCode)
            }
            return result.data
        }
        .eraseToAnyPublisher()
    }

    func decodeData<T: Decodable>(decoder: JSONDecoder) -> AnyPublisher<T, Error> {
        tryData()
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
```

- Plus Test coverage and more! 👨‍💻

## References and helpful resources:

* [SwiftUI Architecture - A Complete Guide to MV Pattern Approach][1]
* [Testing networking logic in Swift][2]

[1]: https://azamsharp.com/2022/10/06/practical-mv-pattern-crud.html
[2]: https://www.swiftbysundell.com/articles/testing-networking-logic-in-swift/
