import Vapor

struct NewLyricsRequest: Content {
    let clientAppId: String
    let index: Int
    let maxCount: Int
}
