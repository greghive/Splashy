import Combine
import Foundation

//MARK: Unsplash Config

let unsplash = API(session: .shared)
let unsplashKey = "iZtw8MF31vX7HRImIxwViLf8LnOBeESxKvNfbihdGHs" // demo key, accepts 50 requests per hour
let unsplashScheme = "https"
let unsplashHost = "api.unsplash.com"
let unsplashHeaders = [
    "Accept-Version": "v1",
    "Authorization": "Client-ID \(unsplashKey)"
]

let unsplashDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

//MARK: Unsplash Requests

extension Request {
    static func searchPhotos(query: String, perPage: Int = 20) -> Request {
        Request(
            method: .get,
            path: "/search/photos",
            queries: ["query": query, "per_page": "\(perPage)"]
        )
    }
}

//MARK: Helpers

fileprivate extension Request {
    init(method: RequestMethod, path: String, queries: [String: String]) {
        self.scheme = unsplashScheme
        self.host = unsplashHost
        self.headers = unsplashHeaders
        self.method = method
        self.path = path
        self.queries = queries
        self.body = nil
    }
}

extension API {
    func call<T: Decodable>(_ request: Request) -> AnyPublisher<T, Error> {
        send(request: request, decoder: unsplashDecoder)
    }
}


