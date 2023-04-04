//
//  WelcomeCollectionViewCell.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 3/6/23.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupComponents() {
        slideImageView.layer.cornerRadius = 20
        slideImageView.layer.borderWidth = 1
        slideImageView.layer.borderColor = UIColor.black.cgColor
        slideTitleLbl.textColor = UIColor(hex: "F6C9E0")
        slideDescriptionLbl.textColor = UIColor(hex: "F6C9E0")
    }

    func configure(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
    
}
