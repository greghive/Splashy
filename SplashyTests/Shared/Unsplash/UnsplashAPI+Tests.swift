
import XCTest
@testable import Splashy

final class UnsplashAPI_Tests: XCTestCase {

    func test_unsplashDecoder_convertsFromSnakeCase() throws {
        let json = ["some_key": "value"]
        let data = try JSONSerialization.data(withJSONObject: json)
        let object = try unsplashDecoder.decode(SomeObject.self, from: data)
        XCTAssertEqual(object.someKey, "value")
    }
    
    func test_unsplashEncoder_convertsToSnakeCase() throws {
        let object = SomeObject(someKey: "value")
        let data = try unsplashEncoder.encode(object)
        let json = String(data: data, encoding: .utf8)
        XCTAssertTrue(json?.contains("some_key") ?? false)
    }
    
    func test_searchPhotos_request() {
        let request = Request.searchPhotos(query: "test", perPage: 100)
        XCTAssertEqual(request.scheme, "https")
        XCTAssertEqual(request.host, "api.unsplash.com")
        XCTAssertEqual(request.headers, ["Accept-Version": "v1", "Authorization": "Client-ID iZtw8MF31vX7HRImIxwViLf8LnOBeESxKvNfbihdGHs"])
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.path, "/search/photos")
        XCTAssertEqual(request.queries, ["query": "test", "per_page": "100"])
    }
}

fileprivate struct SomeObject: Codable {
    let someKey: String
}
