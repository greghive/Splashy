
import XCTest
@testable import Splashy

final class SearchModelTests: XCTestCase {
    private var sut: SearchModel!
    
    override func setUp() {
        sut = SearchModel(favs: .init(cacheKey: #file))
    }
    
    func test_searchState_initially_idle() {
        XCTAssertEqual(sut.searchState, .idle)
    }
    
    func test_searchState_success() {
        // needs a mockable API that will succeed
        XCTFail()
    }
    
    func test_searchState_failure() {
        // needs a mockable API that will fail
        XCTFail()
    }
}

extension SearchModel.SearchState: Equatable {
    public static func == (lhs: SearchModel.SearchState, rhs: SearchModel.SearchState) ->Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case let (.success(a), .success(b)):
            return a == b
        case let (.failure(a), .failure(b)):
            return a == b
        default:
            return false
        }
    }
}
