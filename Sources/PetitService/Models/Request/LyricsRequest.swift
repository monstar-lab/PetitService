import Foundation

struct LyricsRequest: Encodable {
    let lyricsId: Int
    // let title: String?
    // let artistId: Int?
    // let writer: String?
    // let composer: String?
    // let album: String?
    // let freeword: String?
    // let janCode: String?
    // let isrc: String?
    // let duration: Int?
    let clientAppId: String
    let terminalType: Int
    // let userId: String?
    let lyricsType: Int
    // let maxCount: Int?

    enum CodingKeys: String, CodingKey {
        case lyricsId = "key_lyricsId"
        // case title = "key_title"
        // case artistId = "key_artistId"
        // case writer = "key_writer"
        // case composer = "key_composer"
        // case album = "key_album"
        // case freeword = "key_freeword"
        // case janCode = "key_jancode"
        // case isrc = "key_isrc"
        // case duration = "key_duration"
        case clientAppId
        case terminalType
        // case userId
        case lyricsType
        // case maxCount
    }
}
