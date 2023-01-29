
import Foundation

protocol MockURLResponder {
    static func respond(to request: URLRequest) throws -> Data
}

extension URLSession {
    convenience init<T: MockURLResponder>(mockResponder: T.Type) {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol<T>.self]
        self.init(configuration: configuration)
        URLProtocol.registerClass(MockURLProtocol<T>.self)
    }
}
