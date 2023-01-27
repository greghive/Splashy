
import XCTest
@testable import Splashy

final class UnsplashErrorTests: XCTestCase {

    func test_init_withStatusCode() {
        let _400 = UnsplashError(statusCode: 400)
        let _401 = UnsplashError(statusCode: 401)
        let _403 = UnsplashError(statusCode: 403)
        let _404 = UnsplashError(statusCode: 404)
        let _500 = UnsplashError(statusCode: 500)
        let _503 = UnsplashError(statusCode: 503)
        let _999 = UnsplashError(statusCode: 999)
        XCTAssertEqual(_400, .badRequest)
        XCTAssertEqual(_401, .unauthorized)
        XCTAssertEqual(_403, .forbidden)
        XCTAssertEqual(_404, .notFound)
        XCTAssertEqual(_500, .serverError)
        XCTAssertEqual(_503, .serverError)
        XCTAssertEqual(_999, .unknown)
    }
    
    func test_init_withAPIError() {
        let err1 = UnsplashError(.invalidUrl)
        let err2 = UnsplashError(.unexpectedResponse)
        let err3 = UnsplashError(.failure(statusCode: 501))
        XCTAssertEqual(err1, .invalidUrl)
        XCTAssertEqual(err2, .unexpectedResponse)
        XCTAssertEqual(err3, .init(statusCode: 501))
    }
}
