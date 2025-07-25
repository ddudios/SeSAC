//
//  HomeViewController.swift
//  MovieProject
//
//  Created by Suji Jang on 7/2/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    let movies = ["노량", "더퍼스트슬램덩크", "밀수", "범죄도시3", "서울의봄", "스즈메의문단속", "아바타물의길", "오펜하이머", "육사오", "콘크리트유토피아", "1", "2", "3", "4", "5", "극한직업", "도둑들", "명량", "베테랑", "부산행", "신과함께인과연", "신과함께죄와벌", "아바타", "알라딘", "암살", "어벤져스엔드게임", "왕의남자", "태극기휘날리며", "택시운전사", "해운대"]

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var topImageView: [UIImageView]!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var hotMovieButton: [UIButton]!
    
    @IBOutlet var watchLabel: [UILabel]!
    @IBOutlet var newLabel: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designImageViewUI(mainImageView)
        
        for button in hotMovieButton {
            designButtonUI(button)
        }
        
        designButtonUI(playButton)
        designButtonUI(likeButton)
        
        designWatchLabelUI()
        designNewLabelUI()
        
        randomBedge()
    }
    
    func designImageViewUI(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
    }
    
    func designButtonUI(_ button: UIButton) {
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
    }
    
    //forEach vs for in 찾아보고 서로 되고안되고 찾아보기
    
    func designWatchLabelUI() {
        for label in watchLabel {
            label.text = "지금 시청하기"
            label.textColor = .black
            label.backgroundColor = .white
            label.font = .boldSystemFont(ofSize: 12)
            label.textAlignment = .center
        }
    }
    
    func designNewLabelUI() {
        for label in newLabel {
            label.text = "새로운 에피소드"
            label.textColor = .white
            label.backgroundColor = .red
            label.font = .boldSystemFont(ofSize: 12)
            label.textAlignment = .center
            label.layer.cornerRadius = 3
            label.clipsToBounds = true
        }
    }
    
    func randomBedge() {
        for image in topImageView {
            image.image = UIImage(named: "top10 badge")
        }
        
        for image in topImageView {
            image.isHidden = Bool.random()
        }
        
        for label in watchLabel {
            label.isHidden = Bool.random()
        }
        
        for label in newLabel {
            label.isHidden = Bool.random()
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        for button in hotMovieButton {
            button.setImage(UIImage(named: movies[Int.random(in: 0...movies.count-1)]), for: .normal)
            mainImageView.image = UIImage(named: movies[Int.random(in: 0...movies.count-1)])
        }
        
        randomBedge()
    }
    
}
