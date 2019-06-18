
@testable import ContractTestsExample

import XCTest

class SystemDateProviderTest: XCTestCase {

    // En este test no se bien que es lo que deberia probar. No tiene sentido inyectarle otra dependencia a esta clase
    // Como puedo ver que lo que devuelve es la fecha actual?
    
    func testProvidesCurrentDate() {
        
        // Given
        let provider = SystemDateProvider()
        
        // When
        let _ = provider.getCurrentDate()
        
        // Then
        
    }
}
