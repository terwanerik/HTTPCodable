import Foundation
import Futures

public protocol HTTPCodableClient {
    var urlSession: URLSession { get }
    
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
    
    var baseUrl: String? { get }
    
    var sessionConfiguration: URLSessionConfiguration? { get }
    var cachePolicy: URLRequest.CachePolicy? { get }
    var timeoutInterval: TimeInterval? { get }
    
    func request(_ method: HTTPCodableMethod, url: String, body: Data?, query: Encodable?) -> Future<Data>
    
    func get<T: Decodable>(_ url: String, as type: T.Type, query: Encodable?) throws -> Future<T>
    func post<T: Decodable, E: Encodable>(_ data: E?, to url: String, as type: T.Type, query: Encodable?) throws -> Future<T>
    func put<T: Decodable, E: Encodable>(_ data: E?, to url: String, as type: T.Type, query: Encodable?) throws -> Future<T>
    func patch<T: Decodable, E: Encodable>(_ data: E?, to url: String, as type: T.Type, query: Encodable?) throws -> Future<T>
    func delete<T: Decodable>(_ url: String, as type: T.Type, query: Encodable?) throws -> Future<T>
    
    func decode<T: Decodable>(data: Data, to type: T.Type) throws -> T
    func encode<T: Encodable>(data: T) throws -> Data
}

/// Optionals
extension HTTPCodableClient {
    public var urlSession: URLSession {
        return URLSession(configuration: sessionConfiguration ?? .default)
    }
    
    public var encoder: JSONEncoder {
        return JSONEncoder()
    }
    
    public var decoder: JSONDecoder {
        return JSONDecoder()
    }
    
    public var baseUrl: String? {
        return nil
    }
    
    public var sessionConfiguration: URLSessionConfiguration? {
        return nil
    }
    
    public var cachePolicy: URLRequest.CachePolicy? {
        return nil
    }
    
    public var timeoutInterval: TimeInterval? {
        return nil
    }
}
