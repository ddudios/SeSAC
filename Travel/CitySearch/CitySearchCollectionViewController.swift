//
//  CitySearchCollectionViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/17/25.
//

import UIKit

class CitySearchCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var cityListCollectionView: UICollectionView!
    @IBOutlet var CityFilterSegmentedControl: UISegmentedControl!
    
    let cellIdentifier = "CitySearchCollectionViewCell"
    var cityList: [City] = CityInfo().city
    var itemWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let all = CityInfo().city
        
        if sender.selectedSegmentIndex == 0 {
            cityList = all
        } else if sender.selectedSegmentIndex == 1 {
            var domesticArray: [City] = []
            for item in all {
                if item.domestic_travel {
                    domesticArray.append(item)
                }
            }
            cityList = domesticArray
        } else if sender.selectedSegmentIndex == 2 {
            var abroadArray: [City] = []
            for item in all {
                if !item.domestic_travel {
                    abroadArray.append(item)
                }
            }
            cityList = abroadArray
        } else {
            print("error: \(#function)")
        }
        cityListCollectionView.reloadData()
    }
    
    func configureUI() {
        configureNavigation()
        configureCollectionView()
    }
    
    func configureNavigation() {
        configureNavigationBarUI(title: "인기 도시")
    }
    
    func configureCollectionView() {
        cityListCollectionView.delegate = self
        cityListCollectionView.dataSource = self
        
        let xib = UINib(nibName: cellIdentifier, bundle: nil)
        cityListCollectionView.register(xib, forCellWithReuseIdentifier: cellIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (20 * 2) - (20 * 1)
        itemWidth = cellWidth
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: cellWidth/2, height: cellWidth/1.4)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        cityListCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cityListCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CitySearchCollectionViewCell
        
        cell.citySearchCollectionImageView.layer.cornerRadius = itemWidth/4  // (cell이 2개*2) 나누기
        cell.citySearchCollectionImageView.clipsToBounds = true
        
//        cell.cityData = cityList[indexPath.item]
        let item = cityList[indexPath.item]
        let url = URL(string: item.city_image)
        cell.citySearchCollectionImageView.kf.setImage(with: url)
        cell.cityNameLabel.text = "\(item.city_name) | \(item.city_english_name)"
        cell.cityExplainLabel.text = item.city_explain
        
        return cell
    }
}
