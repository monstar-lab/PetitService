import Vapor

public final class PetitClient: Service {
    let httpClient: Client
    let clientId: String
    let baseUrl: URL
    private let dateFormatter: DateFormatter

    public init(
        httpClient: Client,
        clientId: String,
        baseUrl: URL
    ) {
        self.httpClient = httpClient
        self.clientId = clientId
        self.baseUrl = baseUrl
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
    }

    public func fetchSongDetails(
        with id: Int,
        on container: Container
    ) throws -> Future<Song> {
        let url = constructUrl(for: .lyrics)
        let body = lyricsRequestBody(for: id, lyricsType: 0)

        return try getResponse(to: url, body: body)
            .map { result in
                guard let song = result.songs.song?.first else {
                    throw Abort(.preconditionFailed, reason: "Lyrics ID seems to be invalid")
                }

                return song
            }
    }

    public func fetchLyrics(
        with id: Int,
        on container: Container
    ) throws -> Future<Lyrics> {
        let url = constructUrl(for: .lyrics)
        let body = lyricsRequestBody(for: id, lyricsType: 2)

        return try getResponse(to: url, body: body)
            .map { result in
                guard let song = result.songs.song else {
                    throw Abort(.preconditionFailed, reason: "Lyrics ID seems to be invalid")
                }

                guard let lyricsData = song.first?.lyricsData?.data(using: .utf8) else {
                    throw Abort(.expectationFailed, reason: "Failed to fetch lyrics for given song")
                }

                let decoder = JSONDecoder()

                return try decoder.decode(Lyrics.self, from: lyricsData)
            }
    }

    public func getLatestLyrics(
        offset: Int = 0,
        maxCount: Int = 100,
        on container: Container
    ) throws -> Future<[Song]> {
        let url = constructUrl(for: .newLyrics)
        let body = NewLyricsRequest(clientAppId: clientId, index: offset, maxCount: maxCount)

        return try getResponse(to: url, body: body)
            .map { result in
                guard let songs = result.songs.song else {
                    throw Abort(.expectationFailed, reason: "Unable to fetch latest lyrics")
                }

                return songs
            }
    }

    private func constructUrl(for endpoint: Endpoint) -> URL {
        return baseUrl.appendingPathComponent(endpoint.rawValue)
    }

    private func lyricsRequestBody(for lyricsId: Int, lyricsType: Int) -> LyricsRequest {
        return LyricsRequest(
            lyricsId: lyricsId,
            clientAppId: clientId,
            terminalType: kTerminalType,
            lyricsType: lyricsType
        )
    }

    private func getResponse<T>(
        to endpoint: URL,
        body: T
    ) throws -> Future<Result> where T: Content {
        return try httpClient
            .post(endpoint) { request in
                try request.content.encode(body, as: .formData)
            }
            .decodeXML(to: Result.self, using: dateFormatter)
    }
}
