
import Foundation

typealias Storage = ReadableStorage & WritableStorage

protocol ReadableStorage {
    func readData(for key: String) throws -> Data
}

protocol WritableStorage {
    func writeData(_ data: Data, for key: String) throws
}

enum StorageError: Error {
    case notFound
    case writeFailure(Error)
}
