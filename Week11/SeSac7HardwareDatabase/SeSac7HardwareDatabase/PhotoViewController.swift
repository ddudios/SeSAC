//
//  PhotoViewController.swift
//  SeSac7HardwareDatabase
//
//  Created by Suji Jang on 9/9/25.
//

import UIKit
import SnapKit
/**
 시뮬레이터로 카메라 촬영 불가
 캠이 없는 아이폰이 있을 수 있음
 
 카메라 관련 기능:
 1. 카메라로 촬영
 2. 갤러리에서 사진 가져오기
 3. 사진을 갤러리에 저장하기
 => 이 3가지 기능을 iOS 13까지 UIImagePickerController 클래스가 담당하다가 (시스템UI)
    - 카메라 기능을 만들어야겠다, 라이브 필름 앱을 만들어야겠다, 갤러리에서 사진을 가져와야겠다 등
    - 갤러리에서 여러장 선택하는 것 불가능
 => iOS 14부터는 PHPicker(out of process) 가 등장하면서 2, 3의 기능을 담당
    - 1번의 기능은 여전히 UIImagePickerController로 할 수 있다
    - 그래서 요즘은, 촬영 기능만 UIImagePickerController가 담당하고 있고, 갤러리에서 사진을 조회하거나 추가해서 저장하거나 등은 PHPicker가 다루고 있다
    - 여러장 선택 가능
 
 시뮬에서 option키로 줌 등을 할 수 있음
 */

class PhotoViewController: UIViewController {
    
    // ImagePicker 기준으로 만듦
    let manager = UIImagePickerController()
    // 카메라에 관련된 모든 것을 담당: 시스템 UI까지 담당
        // Poodie 등 커스텀하게 촬영하는 앱은 AVFoundation프레임워크 사용하는데, 그냥 간단하게 내 앱에서 촬영하는 기능을 만들고싶다면 (기본 카메라 어플과 같은 UI띄우고싶다) UIImagePickerController사용하면 됨
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        manager.delegate = self
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        imageView.backgroundColor = .lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // manager를 present하기 전에 내부의 프로퍼티 변경
        manager.sourceType = .photoLibrary        /**
                                                   default로 sourceType이 photoLibrary로 되어있어서 갤러리를 띄울 수 있었음
                                                   - 이를 .camera로 바꾸면 촬영 기능으로 바뀌어서 동작이 됨
                                                   - .camera외에 .photoLibrary와 .savedPhotosAlbum이 디프리케이티드된 이유는 iOS 14이상으로 오면서 imagePickerController가 더이상 사용되지 않기 때문
                                                   - 그렇지만 지금 .photoLibrary를 사용하고 있는 중임
                                                   */
        manager.allowsEditing = true        /**
                                             사진을 체크하면 정방형으로 편집할 수 있는 기능이 생김
                                             - 크롭했는데 크롭 전의 원본 이미지가 뜸: info[.originalImage]로 설정했기 때문
                                                - .originalImage는 갤러리에 있는 사진들을 의미하기 때문에
                                                - Editing옵션을 켜두고 피킹을 했을 때, .originalImage를 선택했기 때문
                                             - 편집한 이미지를 쓰고 싶다면 .editedImage를 기준으로 딕셔너리에서 가져와야 확대/크롭 등 편집한 이미지를 그대로 넣어서 사용할 수 있음
                                             - 그래서 편집 옵션이 없으면 .originalImage를 사용해도 되는데, 편집 옵션이 있으면 .editedImage로 조회하는 게 필요하다
                                             */
        
        present(manager, animated: true)        /**
                                                 갤러리화면을 띄워서 사진을 조회하는 것도 결국은 뷰컨트롤러이기 때문에 present 사용
                                                 - UIImagePickerController Manager를 띄움
                                                 viewDidAppear시점에 present를 하니까 일단 갤러리가 뜸
                                                 - 사진/모음(네비게이션 기능) 세그먼트, 사진 클릭시 체크, 검색 기능
                                                 Delegate 연결이 되어있기 때문에
                                                 - 사진을 클릭하는 순간에 내가 사진을 픽했다는 imagePickerController(_:didFinishPickingMediaWithInfo:) 메서드가 호출됨
                                                 - 취소 버튼을 눌렀을 때 imagePickerControllerDidCancel(_:) 액션이 동작함
                                                 */
        
        /**
         # 권한을 안 물어봤는데 갤러리를 띄워주는게 말이 되는지
         - 눈에 보일 때만 앱에서 접근되는 것처럼 보이는 거지, 사실상 접근하고 있는 상태는 아님
         */
    }
}

/**
 UIImagePickerControllerDelegate하려면 UINavigationControllerDelegate도 필요함
 - Navigation에 관련된 건데 왜 필요하지? 둘 다 작성을 해야되게끔 만들어져 있다
 - weak open var delegate: (any UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
 - UIImagePickerController의 delegate는 UIImagePickerControllerDelegate와 UINavigationControllerDelegate를 갖고 있어야함
 - 시스템적으로 갤러리를 띄우면 요즘은 뒤로가기 모션도 쓸 수 있고 사진의 상세페이지도 들어갈 수 있다보니까 UINavigationControllerDelegate도 필요하다
 */
extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 갤러리 화면에서 이미지를 선택한 경우
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        // 사진을 클릭했을 때의 액션 코드를 여기에 작성
        
        /**
         info 딕셔너리를 통해서 접근할 수 있음
         - UIImagePickerController 기능에서는 딕셔너리로 Key:Value가 정의되어있음
         - UIImagePickerController에 InfoKey의 originalImage를 조회
         - 그 외적으로 특정 이미지의 부가적인 정보를 가져오려면 .media 등을 가져오면 됨
         */
//        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        let image = info[.originalImage] as? UIImage  // 갤러리에 있는 이미지
        let image = info[.editedImage] as? UIImage
        
        if let image = image {
            print("이미지 있음")
            
            imageView.image = image
            dismiss(animated: true)
        } else {
            print("잘못된 이미지")
            // 영상 클릭했을 때, 이미지를 못얻어오니까 이미지가 없다고 응답을 줄 수 있음
        }
    }
    
    // 갤러리 화면에서 취소 버튼을 누른 경우
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        
        // present로 사진을 띄워줬으니까 dismiss로 화면을 내려갈 수 있게끔 만들어줌
        dismiss(animated: true)
    }
    
}
