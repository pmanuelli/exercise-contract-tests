
@testable import ContractTestsExample

import XCTest

class RemoteGameServiceTest: GameServiceTest {

    override func createGameService() -> GameService {
        return RemoteGameService()
    }
}
