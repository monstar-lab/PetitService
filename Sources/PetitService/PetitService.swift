import Vapor

enum PetitErrors: Error {
    case invalidBaseUrl
}

public struct PetitConfig: Service {
    let clientId: String
    let baseUrl: URL

    public init(
        clientId: String,
        baseUrl: String
    ) throws {
        guard let url = URL(string: baseUrl) else {
            throw PetitErrors.invalidBaseUrl
        }

        self.clientId = clientId
        self.baseUrl = url
    }
}

public final class PetitProvider: Provider {
    public init() {}

    public func didBoot(_ container: Container) throws -> Future<Void> {
        return .done(on: container)
    }

    public func register(_ services: inout Services) throws {
        services.register { container -> PetitClient in
            let httpClient = try container.make(Client.self)
            let config = try container.make(PetitConfig.self)

            return PetitClient(
                httpClient: httpClient,
                clientId: config.clientId,
                baseUrl: config.baseUrl
            )
        }
    }
}
