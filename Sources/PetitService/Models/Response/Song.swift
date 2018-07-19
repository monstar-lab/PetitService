import Vapor

public struct Song: Content {
    public let title: String
    public let lyricsData: String?
}
