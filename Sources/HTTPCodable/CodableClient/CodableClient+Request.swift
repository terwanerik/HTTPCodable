import Foundation
import Futures

extension CodableClient {
    private func strip(url: String) -> String {
        guard var baseUrl = baseUrl else { return url }
        
        var url = url
        
        if url.first == "/" { url = String(url.dropFirst()) }
        if baseUrl.last == "/" { baseUrl = String(baseUrl.dropLast()) }
        
        return "\(baseUrl)/\(url)"
    }
    
    private func generateUrl(from url: String, with query: Encodable? = nil) -> URL? {
        let cleanUrl = strip(url: url)
        
        guard let query = query else { return URL(string: cleanUrl) }
        guard var components = URLComponents(string: cleanUrl) else { return nil }
        
        components.query = query.httpQuery
        
        return components.url
    }
    
    public func request(_ method: HTTPCodableMethod, url: String, body: Data? = nil,
                        query: Encodable? = nil) -> Future<Data>
    {
        return request(method, url: url, body: body, query: query).future
    }
    
    public func request(_ method: HTTPCodableMethod, url: String, body: Data? = nil,
                        query: Encodable? = nil) -> DataResponse
    {
        let promise = Promise<Data>()
        
        guard let url = generateUrl(from: url, with: query) else {
            promise.reject(HTTPCodableError.invalidUrl)
            
            return (future: promise.future, task: nil)
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: cachePolicy ?? .useProtocolCachePolicy,
                                 timeoutInterval: timeoutInterval ?? 60.0)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return promise.reject(error)
            }
            
            guard let data = data else {
                return promise.reject(HTTPCodableError.invalidResponse)
            }
            
            promise.fulfill(data)
        }
        
        task.resume()
        
        return (future: promise.future, task: task)
    }
}
