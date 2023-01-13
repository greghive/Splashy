
import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

struct Request {
    let scheme: String
    let host: String
    let headers: [String: String]?
    let method: RequestMethod
    let path: String
    let queries: [String: String]?
    let body: Data?
}

extension Request {
    func build() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queries?.map { URLQueryItem(name: $0.key, value: $0.value) }
       
        guard let url = components.url else {
            throw APIError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}
