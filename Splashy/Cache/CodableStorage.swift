
import Foundation

class CodableStorage {
    private let storage: FileStorage
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(storage: FileStorage, decoder: JSONDecoder = .init(), encoder: JSONEncoder = .init()) {
        self.storage = storage
        self.decoder = decoder
        self.encoder = encoder
    }

    func read<T: Decodable>(for key: String) throws -> T {
        let data = try storage.readData(for: key)
        return try decoder.decode(T.self, from: data)
    }

    func write<T: Encodable>(_ value: T, for key: String) throws {
        let data = try encoder.encode(value)
        try storage.writeData(data, for: key)
    }
}
