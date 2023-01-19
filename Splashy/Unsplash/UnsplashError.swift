
import Foundation

//https://unsplash.com/documentation#error-messages

enum UnsplashError: Error {
    case invalidUrl
    case unexpectedResponse
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case unknown
}

extension UnsplashError {
    init(statusCode: Int) {
        switch statusCode {
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 404: self = .notFound
        case 500, 503: self = .serverError
        default: self = .unknown
        }
    }
}

extension UnsplashError {
    init(_ error: APIError) {
        switch error {
        case .invalidUrl:
            self = .invalidUrl
        case .unexpectedResponse:
            self = .invalidUrl
        case .failure(let statusCode):
            self = .init(statusCode: statusCode)
        }
    }
}

extension UnsplashError: CustomStringConvertible {
    var description: String {
        // catch all user facing error
        "There was an issue with Unsplash. Please try again."
    }
}

extension Error {
    var message: String {
        switch self {
        case is URLError:
            return "Cannot reach Unsplash right now. Please try again later."
        case is DecodingError:
            return "Oops! We made a mistake. Please contact support."
        case let err as APIError:
            return "\(UnsplashError(err))"
        default:
            return "Something went wrong."
        }
    }
}
