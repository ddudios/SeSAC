//
//  PhotoPickerViewController.swift
//  SeSac7HardwareDatabase
//
//  Created by Suji Jang on 9/10/25.
//

import UIKit
import SnapKit
import PhotosUI  // iOS14+

class PhotoPickerViewController: UIViewController {

    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        imageView.backgroundColor = .lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 어떤 뷰컨이든 present로 띄워야 하는 것은 마찬가지
        // 버전에 따라 띄울 수 있는 뷰컨의 종류가 많음, 그 중 사진 관련된 것을 보느라 UIImagePickerController를 살펴봤음
//        let picker = UIImagePickerController()  // 어제 썼던 사진 관련된 것
//        let picker = UIFontPickerViewController()  // 이 폰에서 사용 가능한 폰트에 대한 리스트
//        let picker = UIColorPickerViewController()  // 컬러 팔레트
        var config = PHPickerConfiguration()  // 구조체 인스턴스 생성(기본 셋팅 사진첩 뜸)
        config.selectionLimit = 3  // 3장까지 선택 가능
        config.filter = .videos
        config.filter = .any(of: [.screenshots, .images])   /**
                                                             사진, 영상, 사진 중에서도 스크린 샷 등 종류가 많이 있는데 영상은 안가져오고 싶다면 사진들을 필터해서 가져올 수 있음
                                                             - 영상만 다루는 앱이라면 사진은 필요없으니 영상만 가져옴
                                                             - 갖고 올 수 있는 내용을 필터링할 때 사용
                                                             - any로 여러 개 가져올 수도 있음
                                                             - 이미지 피커에는 없는 기능
                                                             */
        let picker = PHPickerViewController(configuration: config)  // 갤러리에 관련된 모든 것을 담당 (촬영 기능은 없음)
        // configuration: 셋팅에 관련된 것
        // PHPicker는 갤러리 관련으로 촬영 X, 여러장 선택 가능
        picker.delegate = self
        present(picker, animated: true)
        
        /**
         picker를 띄우는 적절한 위치?
         - 버튼 클릭시 이미지가 뜨도록 한다면 (앱에서 사진을 얼마나 사용하냐에 따라서도 다름)
         - 뷰컨의 위에 있으면 사용자가 피커를 안띄울 지라도 공간을 차지하고 있음
         - 굳이 인스턴스를 만들어주지 않아도 될 수 있음
         - 버튼 내에 있는 것이 좋을 수도 있고, 뷰컨 내에 있는 것이 좋을 수도 있음
         */
    }
}

extension PhotoPickerViewController: PHPickerViewControllerDelegate {
    
    // 사진 선택 > 취소/추가 버튼 누르면 실행됨
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print(#function, results)  // [PhotosUI.PHPickerResult(itemProvider:
        picker.dismiss(animated: true)  // 매개변수를 통해서 실행 (이 매개변수 picker가 viewDidAppear에 정의한 picker임)
        
        let itemProvider = results.first?.itemProvider  // 컬렉션 뷰에 여러 사진을 보여주고 싶다면, result를 반복문으로 돌릴 수 있음
        if let itemProvider = itemProvider,  // 선택된 item에 대해서,
            itemProvider.canLoadObject(ofClass: UIImage.self) {
                // 갤러리 사진을 UIImage타입으로 로드해서 가져올 수 있는지 물어봄
                // 선택한 상태에서 사진 삭제할 수도 있으니까 파일이 맞지 않을 수도 있음
            
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                // load과정에서 긴 영상을 가져오면 시간이 오래걸릴 것이고 그동안 다른 작업을 할 수 있으니까 global로 돌려주는 코드가 있을 것임 -> 그러니까 UI작업은 Main으로 돌려서 빠르게 적용되어야 함
                
                // 보라색이면 메인으로 올려주거나 백그라운드로 빼거나
                    // UI를 바꾸는 것이기 때문에 메인으로 올려줌
                DispatchQueue.main.async {
                    // 성공했을 때 이미지가 오는데 (any NSItemProviderReading)?타입으로 UIImage타입이 아님 > 타입 캐스팅 해야함
                    self.imageView.image = image as? UIImage
                }
            }
        }
    }
}
