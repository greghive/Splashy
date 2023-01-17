
import XCTest
@testable import Splashy

final class SearchRowModelTests: XCTestCase {
    
    func test_url() {
        let photo = Photo(id: "a", urls: .init(
            raw: "images/raw.jpg",
            full: "images/full.jpg",
            regular: "images/regular.jpg",
            small: "images/small.jpg",
            thumb: "images/thumb.jpg")
        )
        let sut = SearchRow.ViewModel(photo: photo)
        XCTAssertEqual(sut.url, URL(string: "images/thumb.jpg"))
    }
}
