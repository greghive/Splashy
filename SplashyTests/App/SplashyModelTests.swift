
import XCTest
@testable import Splashy

final class SplashyModelTests: XCTestCase {
    private var sut: SplashyModel!
    private let favs = PhotoStore(cacheKey: #file)
    
    func test_searchState_initially_idle() {
        let api = API(session: .init(mockResponder: SearchPhotosSuccessResponder.self))
        sut = SplashyModel(api: api, favs: favs)
        XCTAssertEqual(sut.searchState, .idle)
    }
    
    func test_searchState_success() {
        switch searchState_with(mockResponder: SearchPhotosSuccessResponder.self) {
        case .idle:
            XCTFail("Expected success state, but got idle")
        case .failure(let error):
            XCTFail("Expected success state, but got error (\(error))")
        case .success(let photos):
            XCTAssertTrue(photos.count > 0)
        }
    }
    
    func test_searchState_error() {
        switch searchState_with(mockResponder: SearchPhotosInvalidURLResponder.self) {
        case .idle:
            XCTFail("Expected error state, but got idle")
        case .success(_):
            XCTFail("Expected error state, but got success")
        case .failure(let error):
            XCTAssertEqual(error, "Cannot reach Unsplash right now. Please try again later.")
        }
    }
    
    func searchState_with<T: MockURLResponder>(mockResponder: T.Type) -> SplashyModel.SearchState {
        let api = API(session: .init(mockResponder: mockResponder.self))
        sut = SplashyModel(api: api, favs: favs)
        var state: SplashyModel.SearchState!
        let exp = expectation(description: #function)
        let sub = sut.$searchState
            .dropFirst()
            .sink {
                state = $0
                exp.fulfill()
            }

        sut.searchTerm = "Test"
        waitForExpectations(timeout: 1)
        sub.cancel()
        return state
    }
}
