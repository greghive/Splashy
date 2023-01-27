
import XCTest
@testable import Splashy

final class PhotoStoreTests: XCTestCase {
    private var sut: PhotoStore!
    
    override func setUp() {
        sut = PhotoStore(cacheKey: #file)
    }
    
    override func tearDown() {
        sut.clear()
    }
    
    func test_contains_returnsTrue() {
        let photo = photo(id: "a")
        sut.toggle(photo)
        XCTAssertTrue(sut.contains(photo))
    }
    
    func test_contains_returnsFalse() {
        let photo = photo(id: "a")
        XCTAssertFalse(sut.contains(photo))
    }
    
    func test_toggle_removesExistingPhoto() {
        let photoA = photo(id: "1")
        sut.toggle(photoA)
        let photoB = photo(id: "1")
        sut.toggle(photoB)
        XCTAssertFalse(sut.contains(photoA))
        XCTAssertFalse(sut.contains(photoB))
    }
    
    func test_toggle_addsNewPhoto() {
        let photo = photo(id: "a")
        sut.toggle(photo)
        XCTAssertEqual(sut.photos, [photo])
    }
    
    func test_clear() {
        let photoA = photo(id: "a")
        let photoB = photo(id: "b")
        let photoC = photo(id: "c")
        sut.toggle(photoA)
        sut.toggle(photoB)
        sut.toggle(photoC)
        sut.clear()
        XCTAssertEqual(sut.photos, [])
    }
    
    private func photo(id: String) -> Photo {
        Photo(id: id, description: "", urls: .preview(url: ""), user: .preview)
    }
}
