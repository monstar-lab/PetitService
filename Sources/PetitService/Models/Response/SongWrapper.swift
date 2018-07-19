import Vapor

public struct SongWrapper: Content {
    var song: [Song]?
}
