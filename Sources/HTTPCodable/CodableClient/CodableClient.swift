import Foundation
import Futures

public protocol CodableClient {
    typealias DataResponse = (future: Future<Data>, task: URLSessionTask?)
    typealias Response<T> = (future: Future<T>, task: URLSessionTask?)
    
    var urlSession: URLSession { get }
    
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
    
    var baseUrl: String? { get }
    
    var sessionConfiguration: URLSessionConfiguration? { get }
    var cachePolicy: URLRequest.CachePolicy? { get }
    var timeoutInterval: TimeInterval? { get }
    
    func request(_ method: HTTPCodableMethod, url: String, body: Data?, query: Encodable?) -> Future<Data>
    func request(_ method: HTTPCodableMethod, url: String, body: Data?, query: Encodable?) -> DataResponse
    
    func get<T: Decodable>(_ url: String, as type: T.Type, query: Encodable?) throws -> Future<T>
    func get<T: Decodable>(with url: String, as type: T.Type, query: Encodable?) throws -> Response<T>
    
    func post<T: Decodable, E: Encodable>(_ data: E?, to url: String, as type: T.Type, query: Encodable?) throws -> Future<T>
    func post<T: Decodable, E: Encodable>(with data: E?, to url: String, as type: T.Type, query: Encodable?) throws -> Response<T>
    
    func put<T: Decodable, E: Encodable>(_ data: E?, to url: String, as type: T.Type, query: Encodable?) throws -> Future<T>
    func put<T: Decodable, E: Encodable>(with data: E?, to url: String, as type: T.Type, query: Encodable?) throws -> Response<T>
    
    func patch<T: Decodable, E: Encodable>(_ data: E?, to url: String, as type: T.Type, query: Encodable?) throws -> Future<T>
    func patch<T: Decodable, E: Encodable>(with data: E?, to url: String, as type: T.Type, query: Encodable?) throws -> Response<T>
    
    func delete<T: Decodable>(_ url: String, as type: T.Type, query: Encodable?) throws -> Future<T>
    func delete<T: Decodable>(with url: String, as type: T.Type, query: Encodable?) throws -> Response<T>
    
    func decode<T: Decodable>(data: Data, to type: T.Type) throws -> T
    func encode<T: Encodable>(data: T) throws -> Data
}

/// Optionals
extension CodableClient {
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
