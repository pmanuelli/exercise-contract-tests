
import Foundation

class GamePresenter {
    
    let view: GameView
    let gameService: GameService
    let dateProvider: DateProvider
    
    init(view: GameView, gameService: GameService, dateProvider: DateProvider) {
        self.view = view
        self.gameService = gameService
        self.dateProvider = dateProvider
    }
    
    func createNewGame() {
        
        let date = dateProvider.getCurrentDate()
        
        if let game = gameService.createNewGame(date: date) {
            view.showGame(game)
        }
        else {
            view.showError()
        }
    }
}
