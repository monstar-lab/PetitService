import Vapor

public struct Lyrics: Codable {
    public let lines: [LyricsLine]
}
