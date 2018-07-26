import Vapor

public struct Lyrics: Content {
    public let lines: [LyricsLine]

    public init(lines: [LyricsLine]) {
        self.lines = lines
    }
}
