import Vapor
import XMLCoding

extension Future where T == Response {
    func decodeXML<U>(to: U.Type) throws -> Future<U> where U: Decodable {
        return map(to: U.self) { response in
            guard let data = response.http.body.data else {
                throw Abort(.notAcceptable)
            }

            let decoder = XMLDecoder()

            return try decoder.decode(U.self, from: data)
        }
    }
}
