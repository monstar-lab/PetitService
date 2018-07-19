import Vapor

public struct Result: Content {
    let status: Int
    let songs: SongWrapper
}
