
@testable import ContractTestsExample

import XCTest

class LocalGameServiceTest: GameServiceTest {

    override func createGameService() -> GameService {
        return LocalGameService()
    }
}
