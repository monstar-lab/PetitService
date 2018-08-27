import Vapor

public struct LyricsWord: Codable {
    public let string: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.string = try container.decode(String.self, forKey: .string)
    }
}
