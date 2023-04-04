//
//  CocktailDetailsViewController.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/15/23.
//

import UIKit
import Kingfisher
import AVFoundation

class CocktailDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var ingrLabel: UILabel!
    @IBOutlet weak var instrLabel: UILabel!
    @IBOutlet weak var favoriteCheckImageView: UIImageView!
    @IBOutlet weak var viewForScroll: UIView!
    
    //MARK: - Properties
    var drinks: Drink?
    var isChecked = false
    var player: AVAudioPlayer!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setupComponentsUI()
        setupFavoriteCheckBox()
    }
    
    //MARK: - Methods
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func setupComponentsUI() {
        //2B3A55
        cocktailImageView.clipsToBounds = true
        cocktailImageView.layer.cornerRadius = 20
        nameLabel.textColor = .white
        ingredientsLabel.textColor = .white
        instructionsLabel.textColor = .white
        ingrLabel.textColor = .white
        instrLabel.textColor = .white
        view.backgroundColor = UIColor(hex: "2B3A55")
        viewForScroll.backgroundColor = UIColor(hex: "2B3A55")
    }
    
    func configureUI() {
        guard let drinks = drinks else { return }
        var ingredient = ""
        nameLabel.text = drinks.name
        cocktailImageView.kf.indicatorType = .activity
        cocktailImageView.kf.setImage(with: URL(string: drinks.image ?? ""))
        instructionsLabel.text = drinks.instructions
        drinks.ingredients?.forEach({ingredient += "● \($0)\n"})
        ingredientsLabel.text = ingredient
        
        if FavoritesManager.sharedInstance.isFavorite(cocktailName: drinks.name ?? "") {
            isChecked =  true
            favoriteCheckImageView.image = UIImage(named: "heart_checked")
        }  else {
            favoriteCheckImageView.image = UIImage(named: "heart")
        }
        
    }
    
    func setupFavoriteCheckBox() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        favoriteCheckImageView.isUserInteractionEnabled = true
        favoriteCheckImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped() {
        var imageName = ""
        if isChecked {
            imageName = "heart"
            favoriteCheckImageView.image = UIImage(named: imageName)
            
            //
            if let drinks = drinks {
                FavoritesManager.sharedInstance.removeFromFavorite(cocktail: drinks.name ?? "")
            }
            //
        } else  {
            imageName = "heart_checked"
            favoriteCheckImageView.image = UIImage(named: imageName)
            playSound(soundName: "like_sound")
            if let drinks = drinks {
                guard let managedContext = FavoritesManager.sharedInstance.getContext() else {return}
                let newCocktail = CocktailsCore(context: managedContext)
                newCocktail.name = drinks.name
                newCocktail.image = drinks.image //drinks.image
                newCocktail.ingredient = drinks.ingredients?.joined(separator: "-")
                newCocktail.instruction = drinks.instructions
                FavoritesManager.sharedInstance.saveInFavorites(cocktail: newCocktail)
            }
        }
        favoriteCheckImageView.image = UIImage(named: imageName)
        isChecked.toggle()
    }

}
