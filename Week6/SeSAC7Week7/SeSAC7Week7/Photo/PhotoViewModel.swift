//
//  PhotoViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class PhotoViewModel {
    // 어떤 내용을 input/output으로 할지
    var input: Input
    var output: Output
    
    struct Input {
        var searchButtonTapped: ReviewObservable<Void> = ReviewObservable(())
        var text: ReviewObservable<String?> = ReviewObservable(nil)
        
        // 사진 목록 가져오기
        var fetchButtonTapped: ReviewObservable<Void> = ReviewObservable(())
    }
    
    struct Output {
        // 다양한 방식으로 Output이 나올 수 있다 - 설득만 되면 됨
//        var photo: ReviewObservable<Photo?> = ReviewObservable(nil)  // (뷰모델에서 데이터 가공X) 네트워크통신을 통해 받아온 구조체 자체를 VC에 전달 -> 배치는 뷰컨이 해라
        var overview: ReviewObservable<String> = ReviewObservable("작가: -, 해상도: -")
        
        var image: ReviewObservable<URL?> = ReviewObservable(nil)
        
        // 사진 리스트
        var list: ReviewObservable<[PhotoList]> = ReviewObservable([])
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    private func transform() {
        input.searchButtonTapped.lazyBind {
            print("input searchButtonTapped Bind")
            self.getPhoto()  // 클로저 내부 코드 길어지지 않게, 계속 self를 쓰기 귀찮아서 따로 메서드로 나눔
        }
        
//        input.text.lazyBind {
//            print("input text Bind")
//        }
        
        input.fetchButtonTapped.lazyBind {
            self.getPhotoList()
        }
    }
    
    private func getPhoto() {
        guard let text = input.text.value,
              let photoId = Int(text), photoId >= 0 && photoId <= 100 else {
            print("0~100 사이의 숫자를 입력해주세요.")
            return
        }

//        PhotoManager.shared.getOnePhoto(id: photoId) { photo in
        PhotoManager.shared.getOnePhoto(api: .one(id: photoId)) { [weak self] photo in
            guard let self = self else { return }
//            self.output.photo.value = photo
            let data = "작가: \(photo.author), 해상도: \(photo.width) x \(photo.height)"  // 문자열을 합치는 것도 비즈니스 로직이라고 생각해서, 합친 다음에 뷰컨에 넘겨줌
            self.output.overview.value = data
            
            // 유효한 url인지? 확인하는 것은 뷰모델에서 확인
            let url = URL(string: photo.download_url)
            self.output.image.value = url
        }
    }
    
    private func getPhotoList() {
//        PhotoManager.shared.getPhotoList { photo in
//            self.output.list.value = photo
//        }
        PhotoManager.shared.getPhotoList(api: .list) { photo in
            self.output.list.value = photo
        }
    }
}
