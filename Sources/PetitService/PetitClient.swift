import Vapor

public final class PetitClient: Service {
    let httpClient: Client
    let clientId: String
    let baseUrl: URL

    public init(
        httpClient: Client,
        clientId: String,
        baseUrl: URL
    ) {
        self.httpClient = httpClient
        self.clientId = clientId
        self.baseUrl = baseUrl
    }

    public func fetchLyrics(
        with id: Int,
        on container: Container
    ) throws -> Future<Lyrics> {
        let url = constructUrl(for: .lyrics)
        let body = LyricsRequest(
            lyricsId: id,
            clientAppId: clientId,
            terminalType: 20,
            lyricsType: 2
        )

        return try httpClient
            .post(url) { request in
                try request.content.encode(body, as: .formData)
            }
            .decodeXML(to: Result.self)
            .map { result in
                guard let songWrapper = result.songs.song else {
                    throw Abort(.expectationFailed, reason: "Lyrics ID seems to be invalid")
                }

                guard let lyricsData = songWrapper.first?.lyricsData?.data(using: .utf8) else {
                    throw Abort(.noContent, reason: "Failed to fetch lyrics for given song")
                }

                let decoder = JSONDecoder()

                return try decoder.decode(Lyrics.self, from: lyricsData)
            }
    }

    private func constructUrl(for endpoint: Endpoint) -> URL {
        return baseUrl.appendingPathComponent(endpoint.rawValue)
    }
}
