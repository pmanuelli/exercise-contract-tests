
@testable import ContractTestsExample

import XCTest

class GamePresenterTest: XCTestCase {
    
    func testExpectationCreateNewGame() {
        
        // Given
        let view = DummyGameView()
        let gameService = SpyGameService()
        
        let date = Date()
        let dateProvider = SpyDateProvider(getCurrentDateResult: date)
        
        let presenter = GamePresenter(view: view, gameService: gameService, dateProvider: dateProvider)
        
        // When
        presenter.createNewGame()
        
        // Then
        XCTAssertEqual(dateProvider.getCurrentDateTimesCalled, 1)
        XCTAssertEqual(gameService.createNewGameTimesCalled, 1)
        XCTAssertEqual(gameService.createNewGameDate, date)
    }
    
    func testAnswerCallsShowGame() {
        
        // Given
        let view = SpyGameView()
        
        let game = Game()
        let gameService = StubGameService(createNewGameResult: game)
        
        let dateProvider = DummyDateProvider()
        
        let presenter = GamePresenter(view: view, gameService: gameService, dateProvider: dateProvider)
        
        // When
        presenter.createNewGame()
        
        // Then
        XCTAssertEqual(view.showErrorTimesCalled, 0)
        XCTAssertEqual(view.showGameTimesCalled, 1)
        XCTAssertEqual(view.showGameGame, game)
    }
    
    func testAnswerCallsShowError() {
        
        // Given
        let view = SpyGameView()
        let gameService = StubGameService(createNewGameResult: nil)
        let dateProvider = DummyDateProvider()
        
        let presenter = GamePresenter(view: view, gameService: gameService, dateProvider: dateProvider)
        
        // When
        presenter.createNewGame()
        
        // Then
        XCTAssertEqual(view.showErrorTimesCalled, 1)
        XCTAssertEqual(view.showGameTimesCalled, 0)
    }
}

class DummyGameView: GameView {
    
    func showGame(_ game: Game) { }
    func showError() { }
}

class SpyGameView: GameView {
    
    var showGameTimesCalled = 0
    var showGameGame: Game?
    
    func showGame(_ game: Game) {
        showGameTimesCalled += 1
        showGameGame = game
    }
    
    var showErrorTimesCalled = 0
    
    func showError() {
        showErrorTimesCalled += 1
    }
}

class DummyDateProvider: DateProvider {
    
    func getCurrentDate() -> Date {
        return Date(timeIntervalSince1970: 0)
    }
}

class SpyDateProvider: DateProvider {
    
    private let getCurrentDateResult: Date
    
    init(getCurrentDateResult: Date) {
        self.getCurrentDateResult = getCurrentDateResult
    }
    
    var getCurrentDateTimesCalled = 0
    
    func getCurrentDate() -> Date {
        getCurrentDateTimesCalled += 1
        
        return getCurrentDateResult
    }
}

class SpyGameService: GameService {
    
    var createNewGameTimesCalled = 0
    var createNewGameDate: Date?
    
    func createNewGame(date: Date) -> Game? {
        createNewGameTimesCalled += 1
        createNewGameDate = date
        
        return nil
    }
    
    func getAllGames() -> Array<Game> {
        return []
    }
    
    func getAllGames(from startDate: Date, to endDate: Date) -> Array<Game> {
        return []
    }
}

class StubGameService: GameService {
    
    private let createNewGameGame: Game?
    
    init(createNewGameResult: Game?) {
        self.createNewGameGame = createNewGameGame
    }
    
    func createNewGame(date: Date) -> Game? {
        return createNewGameResult
    }
    
    func getAllGames() -> Array<Game> {
        return []
    }
    
    func getAllGames(from startDate: Date, to endDate: Date) -> Array<Game> {
        return []
    }
}
