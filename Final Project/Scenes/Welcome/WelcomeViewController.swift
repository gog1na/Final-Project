//
//  WelcomeViewController.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 3/6/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - Properties
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "WelcomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WelcomeCollectionViewCell")
        
        slides = [
            OnboardingSlide(title: "უცხოური რეცეპტები", description: "სწრაფი და მარტივი", image: UIImage(named: "1") ?? UIImage()),
            OnboardingSlide(title: "კოქტეილები", description: "გაიხალისე ზაფხული", image: UIImage(named: "2") ?? UIImage()),
            OnboardingSlide(title: "ქართული კერძები", description: "ერთად უკეთესია 🤩", image: UIImage(named: "4") ?? UIImage())
        ]
    }
    
    //MARK: - Actions
    @IBAction func didTapNextBtn(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let storyBoard = UIStoryboard(name: "MainTabBar", bundle: nil)
            let tabBarController = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBarController
            tabBarController.modalTransitionStyle = .flipHorizontal
            navigationController?.pushViewController(tabBarController, animated: true)
            UserDefaults.standard.set("No", forKey:"isFirstTime")
            UserDefaults.standard.synchronize()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    //MARK: - Methods
    func setupUI() {
        nextBtn.layer.cornerRadius = 10
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .white
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCollectionViewCell", for: indexPath) as! WelcomeCollectionViewCell
        cell.configure(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    
}


