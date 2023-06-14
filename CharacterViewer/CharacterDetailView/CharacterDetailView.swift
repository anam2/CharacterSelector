//
//  CharacterDetailView.swift
//  Simpsons
//
//  Created by Admin on 6/13/23.
//

import UIKit

class CharacterDetailView: UIView {
    let characterData: CharacterListData

    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.text = characterData.name
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .bold)
        return label
    }()

    lazy var characterIcon: UIImageView = {
        let imageView = UIImageView()
        let imageWidth: Int = Int(characterData.iconImage.width) ?? 150
        let imageHeight: Int = Int(characterData.iconImage.height) ?? 200
        characterData.getImage { iconImage in
            DispatchQueue.main.async {
                imageView.image = iconImage
            }
        }
        imageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        return imageView

    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = characterData.descriptionText
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.numberOfLines = 0
        return label
    }()

    // MARK: INITIAZLIER

    init(characterData: CharacterListData) {
        self.characterData = characterData
        super.init(frame: .zero)
        setupUI()
    }

    @available (*, unavailable) required init? (coder aDecoder: NSCoder) { nil }

    private func setupUI() {
        addSubview(characterNameLabel)
        characterNameLabel.constrain(to: self, constraints: [.top(20), .centerX()])

        addSubview(characterIcon)
        characterIcon.constrain(to: self, constraints: [.centerX()])
        characterIcon.constrain(to: characterNameLabel, constraints: [.topToBottom(20)])

        addSubview(descriptionLabel)
        descriptionLabel.constrain(to: self, constraints: [.leading(20), .trailing(-20), .bottom(-20)])
        descriptionLabel.constrain(to: characterIcon, constraints: [.topToBottom(20)])
    }

}
