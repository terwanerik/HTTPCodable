import Foundation
import Futures

public final class Client: CodableClient {
    public static let shared = Client()
    
    public var currentSession: URLSessionDataTask?
    public var baseUrl: String?
    
    public var encoder = JSONEncoder()
    public var decoder = JSONDecoder()
    
    convenience init(baseUrl: String) {
        self.init()
        self.baseUrl = baseUrl
    }
}
