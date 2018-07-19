import Vapor

public struct LyricsLine: Codable {
    public let time: Int
    public let words: [LyricsWord]
}
