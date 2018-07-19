import Vapor

public struct SongWrapper: Content {
    public var song: [Song]?
}
