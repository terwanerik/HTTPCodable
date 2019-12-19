import Foundation
import Futures

extension CodableClient {
    public func get<T: Decodable>(_ url: String, as type: T.Type,
                                  query: Encodable? = nil) throws -> Response<T>
    {
        let response: DataResponse = request(.get, url: url, body: nil, query: query)
        
        return (future: response.future.map { data in
            try self.decode(data: data, to: T.self)
        }, task: response.task)
    }
    
    public func get<T: Decodable>(_ url: String, as type: T.Type,
                                  query: Encodable? = nil) throws -> Future<T>
    {
        let response: Response<T> = try get(url, as: T.self, query: query)
        
        return response.future
    }
    
    public func post<T: Decodable, D: Encodable>(_ data: D? = nil, to url: String, as type: T.Type,
                                                 query: Encodable? = nil) throws -> Response<T>
    {
        let body = data != nil ? try encode(data: data!) : nil
        let response: DataResponse = request(.post, url: url, body: body, query: query)
        
        return (future: response.future.map { data in
            try self.decode(data: data, to: T.self)
        }, task: response.task)
    }
    
    public func post<T: Decodable, D: Encodable>(_ data: D? = nil, to url: String, as type: T.Type,
                                                 query: Encodable? = nil) throws -> Future<T>
    {
        let response: Response<T> = try post(data, to: url, as: T.self, query: query)
        
        return response.future
    }
    
    public func put<T: Decodable, D: Encodable>(_ data: D? = nil, to url: String, as type: T.Type,
                                                query: Encodable? = nil) throws -> Response<T>
    {
        let body = data != nil ? try encode(data: data!) : nil
        let response: DataResponse = request(.put, url: url, body: body, query: query)
        
        return (future: response.future.map { data in
            try self.decode(data: data, to: T.self)
        }, task: response.task)
    }
    
    public func put<T: Decodable, D: Encodable>(_ data: D? = nil, to url: String, as type: T.Type,
                                                query: Encodable? = nil) throws -> Future<T>
    {
        let response: Response<T> = try put(data, to: url, as: T.self, query: query)
        
        return response.future
    }
    
    public func patch<T: Decodable, D: Encodable>(_ data: D? = nil, to url: String, as type: T.Type,
                                                  query: Encodable? = nil) throws -> Response<T>
    {
        let body = data != nil ? try encode(data: data!) : nil
        let response: DataResponse = request(.patch, url: url, body: body, query: query)
        
        return (future: response.future.map { data in
            try self.decode(data: data, to: T.self)
        }, task: response.task)
    }
    
    public func patch<T: Decodable, D: Encodable>(_ data: D? = nil, to url: String, as type: T.Type,
                                                  query: Encodable? = nil) throws -> Future<T>
    {
        let response: Response<T> = try patch(data, to: url, as: T.self, query: query)
        
        return response.future
    }
    
    public func delete<T: Decodable>(_ url: String, as type: T.Type,
                                     query: Encodable? = nil) throws -> Response<T>
    {
        let response: DataResponse = request(.get, url: url, body: nil, query: query)
        
        return (future: response.future.map { data in
            try self.decode(data: data, to: T.self)
        }, task: response.task)
    }
    
    public func delete<T: Decodable>(_ url: String, as type: T.Type,
                                     query: Encodable? = nil) throws -> Future<T>
    {
        let response: Response<T> = try delete(url, as: T.self, query: query)
        
        return response.future
    }
}
