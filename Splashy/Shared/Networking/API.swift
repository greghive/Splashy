
import Foundation
import Combine

enum APIError: Error {
    case invalidUrl
    case unexpectedResponse
    case failure(statusCode: Int)
}

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
