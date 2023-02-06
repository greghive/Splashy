
import Foundation

class FileStorage {
    private let fileManager: FileManager
    private let url: URL
    
    init(url: URL, fileManager: FileManager = .default) {
        self.url = url
        self.fileManager = fileManager
    }
}

extension FileStorage: WritableStorage {
    func writeData(_ data: Data, for key: String) throws {
        let url = url.appendingPathComponent(key)
        do {
            try self.createFolders(in: url)
            try data.write(to: url, options: .atomic)
        } catch {
            throw StorageError.writeFailure(error)
        }
    }
    
    private func createFolders(in url: URL) throws {
        let folderUrl = url.deletingLastPathComponent()
        if !fileManager.fileExists(atPath: folderUrl.path) {
            try fileManager.createDirectory(
                at: folderUrl,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
    }
}

extension FileStorage: ReadableStorage {
    func readData(for key: String) throws -> Data {
        let url = url.appendingPathComponent(key)
        guard let data = fileManager.contents(atPath: url.path) else {
            throw StorageError.notFound
        }
        return data
    }
}
