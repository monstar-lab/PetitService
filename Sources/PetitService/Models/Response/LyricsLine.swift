import Vapor

public struct LyricsLine: Codable {
    let time: Int
    let words: [LyricsWord]
}
