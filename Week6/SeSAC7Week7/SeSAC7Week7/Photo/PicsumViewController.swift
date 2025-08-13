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

struct User {
    let age = 10  // 저장프로퍼티, 인스턴스프로퍼티(인스턴스를 만들어야 접근할 수 있기 때문에 인스턴스프로퍼티라고도 부른다)
    static let name = "Jack"  // 저장프로퍼티(데이터를 갖고있냐/없냐), (메타)타입프로퍼티
}
  
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
        
        let jack = User()  // jack은 인스턴스
        jack.age  // 인스턴스는 인스턴스프로퍼티에만 접근 가능
        print(type(of: jack))  // User: 인스턴스의 타입
        
        User.name  // == User.self.name
        let sesac = User.self
        sesac.name
        print(type(of: sesac))  // User.Type: 메타 타입 (User라는 타입이 무슨타입? User.Type)
        
        PhotoManager.shared.callRequest(api: .list, type: [PhotoList].self) { response in
            print("callRequest list", response)
        }
        
        PhotoManager.shared.callRequest(api: .one(id: 10), type: Photo.self) { response in
            // 컴파일 시점에 어떤 타입이 들어가는지 유추할 수 있다
            print("callRequest", response)
            /**
             callRequest Photo(id: "10", author: "Paul Jarvis", width: 2500, height: 1667, url: "https://unsplash.com/photos/6J--NXulQCs", download_url: "https://picsum.photos/id/10/2500/1667")
             */
        }
        
        setupUI()
        setupConstraints()
        bindData()
    }

    
    private func bindData() {
//        viewModel.output.photo.lazyBind {
//            // 우선 통으로 옮겨서 빠르게 코드를 만드는 형태 -> 데이터 정제 후 나눠줘도 됨
//            print("nil일때 데이터가 안뜰 수 있으니까 프린트: viewModel.output.photo.bind")
//            print(self.viewModel.output.photo.value)
//            
//            guard let photo = self.viewModel.output.photo.value else {
//                print("photo가 nil인 상황")
//                return
//            }
//            
//            self.updatePhotoInfo(photo)
//        }
        
        viewModel.output.overview.bind {
            self.infoLabel.text = self.viewModel.output.overview.value
        }
        
        
        viewModel.output.image.lazyBind {
            if let url = self.viewModel.output.image.value {
                self.photoImageView.kf.setImage(with: url)
                // 킹피셔는 어쩔수없는 라이브러리코드이지만, 링크로 이미지변환은 결국 네트워킹, 파고 들어가면 결국 AF처럼 뭔가 다운로드 받을텐데 뷰컨에서 하는게 맞나?
            }
        }
        
        viewModel.output.list.bind {
            self.tableView.reloadData()
        }
    }
    
    func metatype1() {
        var nickname = "고래밥"
        // nickname은 인스턴스(실질적인 데이터 "고래밥"), 타입은 String
        print(nickname)  // 고래밥
        print(type(of: nickname))  // String
        
        var age = User()
        // age는 인스턴스(실질적인 데이터 User()), User는 타입
        print(age)  // User(age: 10)
        print(type(of: age))  // User
        
        print(type(of: User.self))  // User.Type
        print(type(of: String.self))  // String.Type(메타타입: 타입의 타입): String 그 자체에 대한 타이
        /**
         String의 인스턴스는 고래밥, User의 인스턴스는 User(age:10), String.Type의 인스턴스 String.self
         */
    }
    
    @objc private func searchButtonTapped() {
        // 항상 시점을 고려해서 작성
        viewModel.input.searchButtonTapped.value = ()
        viewModel.input.text.value = textField.text
    }
    
    private func updatePhotoInfo(_ photo: Photo) {
        infoLabel.text = "작가: \(photo.author), 해상도: \(photo.width) x \(photo.height)"
        
        if let url = URL(string: photo.download_url) {
            photoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        }
    }
    
    @objc private func listButtonTapped() {
        viewModel.input.fetchButtonTapped.value = ()
//        PhotoManager.shared.getPhotoList { photo in
//            self.photoList = photo
//            self.tableView.reloadData()
//        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
 
extension PicsumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return photoList.count
        return viewModel.output.list.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        
        let photo = viewModel.output.list.value[indexPath.row]
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
         
//        infoLabel.text = "작가: - | 해상도: -"  // 이 데이터도 데이터 가공아니야? 라고 생각할 수도 있다
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
