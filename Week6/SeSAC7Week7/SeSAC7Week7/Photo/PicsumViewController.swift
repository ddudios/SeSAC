//
//  NetworkViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//
import UIKit
import SnapKit
import Alamofire
import Kingfisher
  
class PicsumViewController: UIViewController {
     
    private let textField = UITextField()
    private let searchButton = UIButton()
    private let photoImageView = UIImageView()
    private let infoLabel = UILabel()
    
    private let listButton = UIButton()
    private let tableView = UITableView()
     
    private var photoList: [PhotoList] = []
     
    let viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    @objc private func searchButtonTapped() {
        guard let text = textField.text, let photoId = Int(text), photoId >= 0 && photoId <= 100 else {
            print("0~100 사이의 숫자를 입력해주세요.")
            return
        }
        
        PhotoManager.shared.getOnePhoto(id: photoId) { photo in
            self.updatePhotoInfo(photo)
        }
    }
    
    private func updatePhotoInfo(_ photo: Photo) {
        infoLabel.text = "작가: \(photo.author), 해상도: \(photo.width) x \(photo.height)"
        
        if let url = URL(string: photo.download_url) {
            photoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        }
    }
    
    @objc private func listButtonTapped() {
        PhotoManager.shared.getPhotoList { photo in
            self.photoList = photo
            self.tableView.reloadData()
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
 
extension PicsumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        
        let photo = photoList[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
}

extension PicsumViewController {
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Picsum Photos"
         
        textField.borderStyle = .roundedRect
        textField.placeholder = "0~100 사이의 숫자 입력"
        textField.keyboardType = .numberPad
        view.addSubview(textField)
         
        searchButton.setTitle("검색", for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.layer.cornerRadius = 8
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)
         
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.backgroundColor = .systemGray6
        photoImageView.layer.cornerRadius = 8
        photoImageView.clipsToBounds = true
        view.addSubview(photoImageView)
         
        infoLabel.text = "작가: - | 해상도: -"
        infoLabel.font = .systemFont(ofSize: 14, weight: .medium)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        view.addSubview(infoLabel)
         
        listButton.setTitle("사진 목록 가져오기", for: .normal)
        listButton.backgroundColor = .systemGreen
        listButton.setTitleColor(.white, for: .normal)
        listButton.layer.cornerRadius = 8
        listButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
        view.addSubview(listButton)
         
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.layer.cornerRadius = 8
        tableView.backgroundColor = .systemGray6
        view.addSubview(tableView)
         
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-12)
            make.height.equalTo(44)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(textField)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(44)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(150)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        listButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(listButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }

}
