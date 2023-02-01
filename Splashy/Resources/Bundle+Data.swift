
import Foundation

extension Bundle {
    func decode<T: Decodable>(_ resource: String, with decoder: JSONDecoder) -> T {
        guard let url = self.url(forResource: resource, withExtension: nil) else {
            fatalError("URL not found for \(resource)")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load data from \(url)")
        }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode \(resource) as \(T.self). Error: \(error)")
        }
    }
}
