
import Foundation

protocol GameService {
    
    func createNewGame(date: Date) -> Game?
    func getAllGames() -> Array<Game>
    func getAllGames(from startDate: Date, to endDate: Date) -> Array<Game>
}
