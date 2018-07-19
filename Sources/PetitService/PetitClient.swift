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
    ) throws -> Future<Result> {
        let url = constructUrl(for: .lyrics)
        let body = LyricsRequest(
            lyricsId: id,
            clientAppId: clientId,
            terminalType: 20,
            lyricsType: 2
        )

        return try httpClient.post(url) { request in
            try request.content.encode(body, as: .formData)
        }.decodeXML(to: Result.self)
    }

    private func constructUrl(for endpoint: Endpoint) -> URL {
        return baseUrl.appendingPathComponent(endpoint.rawValue)
    }
}
