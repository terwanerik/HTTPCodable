import XCTest
@testable import HTTPCodable

final class HTTPCodableTests: XCTestCase {
    struct Todo: Codable {
        var id: Int
        var userId: Int
        var title: String
        var completed: Bool
    }
    
    struct TodoQuery: Codable {
        var id: Int?
        var userId: Int?
        var completed: Bool?
    }
    
    func testSingleGet() {
        let url = "https://jsonplaceholder.typicode.com/todos/1"
        let future = try! Client.shared.get(url, as: Todo.self)
        
        let expectation = XCTestExpectation(description: "Get a single Todo item")
        
        future.whenFulfilled { todo in
            XCTAssertEqual(todo.id, 1)
            
            expectation.fulfill()
        }
        
        future.whenRejected { error in
            XCTAssert(false, "Got error: \(error)")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testMultipleGet() {
        let url = "https://jsonplaceholder.typicode.com/todos"
        let future = try! Client.shared.get(url, as: [Todo].self)
        
        let expectation = XCTestExpectation(description: "Get a list of Todo items")
        
        future.whenFulfilled { todos in
            XCTAssertGreaterThan(todos.count, 1)
            
            expectation.fulfill()
        }
        
        future.whenRejected { error in
            XCTAssert(false, "Got error: \(error)")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testQuery() {
        let url = "https://jsonplaceholder.typicode.com/todos"
        let query = TodoQuery(id: 6, userId: nil, completed: nil)
        let future = try! Client.shared.get(url, as: [Todo].self, query: query)
        
        let expectation = XCTestExpectation(description: "Query a list of Todo items")
        
        future.whenFulfilled { todos in
            XCTAssertEqual(todos.count, 1)
            XCTAssertEqual(todos.first?.id, 6)
            
            expectation.fulfill()
        }
        
        future.whenRejected { error in
            XCTAssert(false, "Got error: \(error)")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testAdvancedQuery() {
        let url = "https://jsonplaceholder.typicode.com/todos"
        let query = TodoQuery(id: nil, userId: 6, completed: true)
        let future = try! Client.shared.get(url, as: [Todo].self, query: query)
        
        let expectation = XCTestExpectation(description: "Query a list of Todo items")
        
        future.whenFulfilled { todos in
            XCTAssertGreaterThan(todos.count, 1)
            XCTAssertEqual(todos.first?.userId, 6)
            XCTAssert(todos.first?.completed ?? false)
            
            expectation.fulfill()
        }
        
        future.whenRejected { error in
            XCTAssert(false, "Got error: \(error)")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPost() {
        let url = "https://jsonplaceholder.typicode.com/todos"
        let data = Todo(id: 1, userId: 1, title: "Foo", completed: true)
        let future = try! Client.shared.post(data, to: url, as: Todo.self)
        
        let expectation = XCTestExpectation(description: "Post a Todo item")
        
        future.whenFulfilled { todo in
            XCTAssertEqual(todo.title, "Foo")
            
            expectation.fulfill()
        }
        
        future.whenRejected { error in
            XCTAssert(false, "Got error: \(error)")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPut() {
        let url = "https://jsonplaceholder.typicode.com/todos/1"
        let data = Todo(id: 1, userId: 1, title: "Foo", completed: true)
        let future = try! Client.shared.put(data, to: url, as: Todo.self)
        
        let expectation = XCTestExpectation(description: "Put a Todo item")
        
        future.whenFulfilled { todo in
            XCTAssertEqual(todo.title, "Foo")
            
            expectation.fulfill()
        }
        
        future.whenRejected { error in
            XCTAssert(false, "Got error: \(error)")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    struct EmptyResponse: Codable {}
    
    func testDelete() {
        let url = "https://jsonplaceholder.typicode.com/todos/1"
        let future = try! Client.shared.delete(url, as: EmptyResponse.self)
        
        let expectation = XCTestExpectation(description: "Delete a Todo item")
        
        future.whenFulfilled { result in
            expectation.fulfill()
        }
        
        future.whenRejected { error in
            XCTAssert(false, "Got error: \(error)")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testBaseUrl() {
        Client.shared.baseUrl = "https://jsonplaceholder.typicode.com/"
        
        let endpoint = "/todos/1"
        let future = try! Client.shared.get(endpoint, as: Todo.self)
        
        let expectation = XCTestExpectation(description: "Get a single Todo item")
        
        future.whenFulfilled { todo in
            XCTAssertEqual(todo.id, 1)
            
            expectation.fulfill()
        }
        
        future.whenRejected { error in
            XCTAssert(false, "Got error: \(error)")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    static var allTests = [
        ("testSingleGet", testSingleGet),
        ("testMultipleGet", testMultipleGet),
        ("testQuery", testQuery),
        ("testAdvancedQuery", testAdvancedQuery),
        ("testPost", testPost),
        ("testPut", testPut),
        ("testDelete", testDelete),
        ("testBaseUrl", testBaseUrl),
    ]
}
