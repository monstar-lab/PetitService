import Vapor

public struct Song: Content {
    let title: String
    let lyricsData: String?
}
