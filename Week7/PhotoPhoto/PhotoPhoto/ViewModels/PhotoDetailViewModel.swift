//
//  PhotoDetailViewModel.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/18/25.
//

import Foundation

final class PhotoDetailViewModel {
    var input: Input
    var output: Output
    
    struct Input {
        var viewDidLoad = Observable("")
        var likeButtonTapped = Observable(())
    }
    
    struct Output {
        var info: Observable<Statistic> = Observable(Statistic(id: "", downloads: Download(total: 0, historical: DownloadHistorical(values: [])), views: Views(total: 0, historical: ViewHistorical(values: []))))
        var like = Observable(false)
    }
    
    init() {
        input = Input()
        output = Output()
        
        input.viewDidLoad.lazyBind { [weak self] data in
            guard let self else { return }
            callRequest(imageId: data)
            getLikeButton(imageId: data)
        }
        
        input.likeButtonTapped.lazyBind { [weak self] _ in
            guard let self else { return }
            output.like.data.toggle()
            setLikeButton()
        }
    }
    
    private func callRequest(imageId: String) {
        NetworkMananger.shared.callRequest(api: .statistics(imageId: imageId), type: Statistic.self) { success in
            self.output.info.data = success
            print(success)
        } failure: { error in
            print("errer: \(error)")
        }
    }
    
    private func getLikeButton(imageId: String) {
        output.like.data = UserDefaults.standard.bool(forKey: imageId)
    }
    
    private func setLikeButton() {
        UserDefaults.standard.set(output.like.data, forKey: input.viewDidLoad.data)
    }
}
