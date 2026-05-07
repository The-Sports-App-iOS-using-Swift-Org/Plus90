
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import Foundation

protocol SportsViewProtocol: AnyObject {
    func startAnimating()
    func stopAnimating()
    func reloadCollection()
}

protocol SportsPresenterProtocol {
    func attachView(_ view: SportsViewProtocol)
    func getSportsCount() -> Int
    func getSport(at index: Int) -> Sport
    func didSelectSport(at index: Int)
}

class SportsPresenter: SportsPresenterProtocol {
    weak var view: SportsViewProtocol?
    private let sportsData: [Sport] = [
        Sport(name: "Football", image: "football"),
        Sport(name: "Tennis", image: "tennis"),
        Sport(name: "Cricket", image: "cricket"),
        Sport(name: "Basketball", image: "basket")
    ]
    func attachView(_ view: SportsViewProtocol) {
        self.view = view
    }
    func getSportsCount() -> Int {
        return sportsData.count
    }
    func getSport(at index: Int) -> Sport {
        return sportsData[index]
    }
    func didSelectSport(at index: Int) {
        let selectedSport = sportsData[index]
        print("Selected: \(selectedSport.name)")
    }
}

