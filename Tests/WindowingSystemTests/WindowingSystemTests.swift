import Testing

struct WindowingSystemTests {
    
    @Test func testNewWindow() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        #expect(
            Window().display() ==
            "New Window\nPosition: (0, 0), Size: (80 x 60)\n[This window intentionally left blank]\n")
    }
    
    @Test func testMainWindow() async throws {
        
        #expect(
            mainWindow.display() ==
            "Main Window\nPosition: (100, 100), Size: (400 x 300)\nThis is the main window\n")
    }
    
    @Test func testPositionMove() async throws {
        
        var pos = Position()
        let newX = Int.random(in: 0...100)
        let newY = Int.random(in: 0...1000)
        pos.moveTo(newX: newX, newY: newY)
        #expect(
            (pos.x == newX && pos.y == newY) == true,
            "Expected: Position(x: \(newX), \(newY)), got Position(x: \(pos.x), \(pos.y))")
    }
    
    @Test func testResize() async throws {
        
        var size = Size()
        let newWidth = Int.random(in: 0...100)
        let newHeight = Int.random(in: 0...1000)
        size.resize(newWidth: newWidth, newHeight: newHeight)
        #expect(
            (size.width == newWidth && size.height == newHeight) == true,
            "Expected: Size(width: \(newWidth), height: \(newHeight)), got Size(width: \(size.width), height: \(size.height))")
    }
    
    @Test func testMoveValid() async throws {
        
        let testWindow: Window = {
            let window = Window()
            window.title = "Test Window"
            window.contents = "test"
            window.resize(to: Size(width: 100, height: 100))
            window.move(to: Position(x: 100, y: 100))
            return window
        }()
        #expect(
            testWindow.display() ==
            "Test Window\nPosition: (100, 100), Size: (100 x 100)\ntest\n")
    }
    
    @Test func testMoveTooFar() async throws {
        
        let testWindow: Window = {
            let window = Window()
            window.title = "Test Window"
            window.contents = "test"
            window.resize(to: Size(width: 100, height: 100))
            window.move(to: Position(x: 750, y: 650))
            return window
        }()
        #expect(
            testWindow.display() ==
            "Test Window\nPosition: (700, 500), Size: (100 x 100)\ntest\n")
    }
    
    @Test func testMoveNegative() async throws {
        
        let testWindow: Window = {
            let window = Window()
            window.title = "Test Window"
            window.contents = "test"
            window.resize(to: Size(width: 100, height: 100))
            window.move(to: Position(x: -80, y: -60))
            return window
        }()
        #expect(
            testWindow.display() ==
            "Test Window\nPosition: (0, 0), Size: (100 x 100)\ntest\n")
    }
    
    @Test func testResizeValid() async throws {
        
        let testWindow: Window = {
            let window = Window()
            window.title = "Test Window"
            window.contents = "test"
            window.move(to: Position(x: 600, y: 500))
            window.resize(to: Size(width: 100, height: 100))
            return window
        }()
        #expect(
            testWindow.display() ==
            "Test Window\nPosition: (600, 500), Size: (100 x 100)\ntest\n")
    }
    
    @Test func testResizeTooFar() async throws {
        
        let testWindow: Window = {
            let window = Window()
            window.title = "Test Window"
            window.contents = "test"
            window.move(to: Position(x: 710, y: 525))
            window.resize(to: Size(width: 1000, height: 1000))
            return window
        }()
        #expect(
            testWindow.display() ==
            "Test Window\nPosition: (710, 525), Size: (90 x 75)\ntest\n")
    }
    
    @Test func testResizeNegative() async throws {
        
        let testWindow: Window = {
            let window = Window()
            window.title = "Test Window"
            window.contents = "test"
            window.resize(to: Size(width: 0, height: -100))
            return window
        }()
        #expect(
            testWindow.display() ==
            "Test Window\nPosition: (0, 0), Size: (1 x 1)\ntest\n")
    }
    
    @Test func testUpdateTitle() async throws {
        
        let window = Window()
        window.update(title: "Did it change?")
        #expect(
            window.display() ==
            "Did it change?\nPosition: (0, 0), Size: (80 x 60)\n[This window intentionally left blank]\n")
    }
    
    @Test func testUpdateText() async throws {
        
        let window = Window()
        window.update(text: "Did it change?")
        #expect(
            window.display() == "New Window\nPosition: (0, 0), Size: (80 x 60)\nDid it change?\n")
    }
    
    @Test func testUpdateTextNil() async throws {
        
        let window = Window()
        window.update(text: "Did it change?")
        window.update(text: nil)
        #expect(
            window.display() ==
            "New Window\nPosition: (0, 0), Size: (80 x 60)\n[This window intentionally left blank]\n")
    }
    
}
