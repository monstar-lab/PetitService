import Vapor

public struct Lyrics: Codable {
    public let lines: [LyricsLine]

    public init(lines: [LyricsLine]) {
        self.lines = lines
    }
}
