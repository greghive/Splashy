
import XCTest
@testable import Splashy

final class SearchModelTests: XCTestCase {
    private var sut: SearchModel!
    private let favs = PhotoStore(cacheKey: #file)
    
    func test_searchState_initially_idle() {
        let api = API(session: .init(mockResponder: SearchPhotosSuccessResponder.self))
        sut = SearchModel(api: api, favs: favs)
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
    
    func searchState_with<T: MockURLResponder>(mockResponder: T.Type) -> SearchModel.SearchState {
        let api = API(session: .init(mockResponder: mockResponder.self))
        sut = SearchModel(api: api, favs: favs)
        var state: SearchModel.SearchState!
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
