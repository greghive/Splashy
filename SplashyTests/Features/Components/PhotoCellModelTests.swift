
import XCTest
@testable import Splashy

final class PhotoCellModelTests: XCTestCase {
    
    func test_url_isThumb() {
        let urls = PhotoUrls(
            raw: "images/raw.jpg",
            full: "images/full.jpg",
            regular: "images/regular.jpg",
            small: "images/small.jpg",
            thumb: "images/thumb.jpg"
        )
        let photo = Photo(id: "a", description: "", urls: urls, user: .preview)
        let sut = PhotoCellModel(photo: photo)
        XCTAssertEqual(sut.url, URL(string: "images/thumb.jpg"))
    }
}
