import Foundation
import Futures

extension HTTPCodableClient {
    public func decode<T: Decodable>(data: Data, to type: T.Type) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
    
    public func encode<T: Encodable>(data: T) throws -> Data {
        return try encoder.encode(data)
    }
}
