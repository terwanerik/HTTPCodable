import Foundation
import Futures

extension HTTPCodableClient {
    public func get<T: Decodable>(_ url: String, as type: T.Type,
                                  query: Encodable? = nil) throws -> Future<T>
    {
        return request(.get, url: url, body: nil, query: query).map { data in
            try self.decode(data: data, to: T.self)
        }
    }
    
    public func post<T: Decodable, D: Encodable>(_ data: D? = nil, to url: String, as type: T.Type,
                                                 query: Encodable? = nil) throws -> Future<T>
    {
        let body = data != nil ? try encode(data: data!) : nil
        
        return request(.post, url: url, body: body, query: query).map { data in
            try self.decode(data: data, to: T.self)
        }
    }
    
    public func put<T: Decodable, D: Encodable>(_ data: D? = nil, to url: String, as type: T.Type,
                                                query: Encodable? = nil) throws -> Future<T>
    {
        let body = data != nil ? try encode(data: data!) : nil
        
        return request(.put, url: url, body: body, query: query).map { data in
            try self.decode(data: data, to: T.self)
        }
    }
    
    public func patch<T: Decodable, D: Encodable>(_ data: D? = nil, to url: String, as type: T.Type,
                                                  query: Encodable? = nil) throws -> Future<T>
    {
        let body = data != nil ? try encode(data: data!) : nil
        
        return request(.patch, url: url, body: body, query: query).map { data in
            try self.decode(data: data, to: T.self)
        }
    }
    
    public func delete<T: Decodable>(_ url: String, as type: T.Type,
                                     query: Encodable? = nil) throws -> Future<T>
    {
        return request(.get, url: url, body: nil, query: query).map { data in
            try self.decode(data: data, to: T.self)
        }
    }
}
