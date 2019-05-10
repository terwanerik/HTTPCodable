import Foundation

extension Encodable {
    public var httpQuery: String {
        var string = ""
        
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            guard let label = child.label?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                continue
            }
            
            if case Optional<Any>.none = child.value {
                continue
            }
    
            var value = String(describing: child.value)
            
            if value.starts(with: "Optional(") {
                value.removeFirst(9)
                
                value = String(value.dropLast())
            }
            
            guard let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                continue
            }
            
            string += "&\(label)=\(escapedValue)"
        }
        
        return String(string.dropFirst())
    }
}
