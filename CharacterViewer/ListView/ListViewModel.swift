//
//  ListViewModel.swift
//  Simpsons
//
//  Created by Admin on 6/13/23.
//

import Foundation
import UIKit

class ListViewModel {
    static let searchBarPlaceHolderText = NSLocalizedString("seachBarPlaceHolderText", comment: "")

    /// The list of all the characters.
    var characterList: [CharacterListData] = []
    /// The list of the filtered results from the search bar.
    var filteredCharacterList: [CharacterListData] = []

    func populateData(completion: @escaping () -> Void) {
        Service.shared.fetchData { result in
            switch result {
            case .success(let characterListDataModel):
                for character in characterListDataModel.characterListDataModel {
                    self.characterList.append(CharacterListData.parseTo(from: character))
                }
                self.filteredCharacterList = self.characterList
                completion()
            case .failure(let error):
                print("Error occured: \(error.localizedDescription)")
            }
        }
    }
}
