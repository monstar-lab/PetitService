import Vapor

public struct Song: Content {
    public let title: String
    public let artist: String
    public let duration: Int
    public let lyricsData: String?
    public let uploadDate: Date
    public let releaseDate: Date?
}
