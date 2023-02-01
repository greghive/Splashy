
import XCTest
@testable import Splashy

final class PhotoCellModelTests: XCTestCase {
    
    func test_url_isThumb() {
        let sut = PhotoCellModel(photo: Photo.stubs[0])
        XCTAssertEqual(
            sut.url,
            URL(string: "https://images.unsplash.com/photo-1553531384-cc64ac80f931?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMTkxMzB8MXwxfHNlYXJjaHwxfHxtb3VudGFpbnxlbnwwfHx8fDE2NzQ5MzY0Mzg&ixlib=rb-4.0.3&q=80&w=200")
        )
    }
}
