
import Foundation

class RemoteGameService: GameService {
    
    func createNewGame(date: Date) -> Game? {
        return Game()
    }
    
    func getAllGames() -> Array<Game> {
        return []
    }
    
    func getAllGames(from startDate: Date, to endDate: Date) -> Array<Game> {
        return []
    }
}
