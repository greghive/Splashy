
import XCTest
@testable import Splashy

final class RequestTests: XCTestCase {
    
    func test_build_request_url() throws {
        XCTAssertEqual(try request(.get).build().url, URL(string: "https://awesome.com/get/stuff"))
    }
    
    func test_build_throwsInvalidUrl() {
        let badRequest = Request(
            scheme: "https",
            host: "awesomecom",
            headers: nil,
            method: .get,
            path: "get/stuff",
            queries: nil,
            body: nil
        )
        do {
            let _ = try badRequest.build()
            XCTFail("No error thrown for invalid URL")
        } catch { }
    }
    
    func test_build_request_url_queries() throws {
        let queries = ["a": "1", "b": "2"]
        if let url = try request(.get, queries).build().url {
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            XCTAssertTrue(components!.queryItems!.contains(URLQueryItem(name: "a", value: "1")), "Query is missing")
            XCTAssertTrue(components!.queryItems!.contains(URLQueryItem(name: "b", value: "2")), "Query is missing")
        } else {
            XCTFail("URL is nil")
        }
    }
    
    func test_build_request_headers() throws {
        XCTAssertEqual(try request(.get).build().allHTTPHeaderFields, ["Accept-Version": "v1", "Authorization": "Client-ID abc"])
    }
    
    func test_build_get_request() throws {
        let get = request(.get)
        XCTAssertEqual(try get.build().httpMethod, "GET")
    }
    
    func test_build_post_request() throws {
        let post = request(.post)
        XCTAssertEqual(try post.build().httpMethod, "POST")
    }
    
    func test_build_delete_request() throws {
        let delete = request(.delete)
        XCTAssertEqual(try delete.build().httpMethod, "DELETE")
    }
    
    private func request(_ method: RequestMethod, _ queries: [String: String]? = nil) -> Request {
        Request(
            scheme: "https",
            host: "awesome.com",
            headers: ["Accept-Version": "v1", "Authorization": "Client-ID abc"],
            method: method,
            path: "/get/stuff",
            queries: queries,
            body: nil
        )
    }
}
