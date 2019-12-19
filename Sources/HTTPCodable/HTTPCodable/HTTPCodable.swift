import Foundation
import Futures

public protocol HTTPCodable: Codable {
    var client: CodableClient { get }
    var endpoint: String { get }
    
    static func get(from endpoint: String?, query: Encodable?) -> Self
    static func get(from endpoint: String?, query: Encodable?) -> [Self]
}
