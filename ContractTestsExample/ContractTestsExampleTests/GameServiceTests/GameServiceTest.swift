
@testable import ContractTestsExample

import XCTest

class GameServiceTest: XCTestCase {

    func test_createsAGame() {

        XCTAssertNotNil(createGameService().createNewGame(date: Date()))
    }
    
    func createGameService() -> GameService {
        return LocalGameService()
    }
}
