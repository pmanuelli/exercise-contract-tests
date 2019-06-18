
@testable import ContractTestsExample

import XCTest

class GamePresenterTest: XCTestCase {
    
    // Este es un test de expectations
    // Sobre las interacciones de GamePresenter (client) con DateProvider y GameService (servers)
    
    func testCreateNewGameExpectations() {
        
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
    
    // Este es un test de answer y pero tambien de expectations
    // El escenario es el mismo que el anterior, pero aca hago foco sobre el caso en que la respuesta del GameService es un game no nulo.
    // Luego de eso se testean interacciones de GamePresenter (client) con GameView (server)
    
    func testCallsShowGame() {
        
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
    
    // Este es otro test de answer y expectations
    // El escenario es el mismo que el anterior, pero para el caso de respuesta nula.
    // Luego de eso se testean interacciones de GamePresenter (client) con GameView (server)
    
    func testCallsShowError() {
        
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

class StubGameService: GameService {
    
    private let createNewGameResult: Game?
    
    init(createNewGameResult: Game?) {
        self.createNewGameResult = createNewGameResult
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
