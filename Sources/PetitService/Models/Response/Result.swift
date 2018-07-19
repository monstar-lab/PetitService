import Vapor

public struct Result: Content {
    public let status: Int
    public let songs: SongWrapper
}
