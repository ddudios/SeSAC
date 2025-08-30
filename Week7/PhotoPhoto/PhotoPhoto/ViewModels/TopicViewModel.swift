//
//  TopicViewModel.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/17/25.
//

import Foundation

final class TopicViewModel {
    var input: Input
    var output: Output
    
    private let group = DispatchGroup()
    private var topicsArray: [TopicData] = []
    
    struct Input {
        var reload = Observable(())
    }
    
    struct Output {
        var topics: Observable<[TopicData]> = Observable([])
    }
    
    init() {
        input = Input()
        output = Output()
        
        input.reload.lazyBind { _ in
            self.dispatchGroup()
        }
    }
    
    private func callRequest(topicId: String) {
        NetworkMananger.shared.callRequest(api: .topic(topicId: topicId), type: [Topic].self) { success in
            self.topicsArray.append(TopicData(title: topicId, topics: success))
            self.group.leave()
        } failure: { error in
            print("errer: \(error)")
            self.group.leave()
        }
    }
    
    private func dispatchGroup() {
        
        group.enter()
        callRequest(topicId: TopicId.goldenHour.rawValue)
        
        group.enter()
        callRequest(topicId: TopicId.business.rawValue)
        
        group.enter()
        callRequest(topicId: TopicId.architecture.rawValue)
        
        group.notify(queue: .main) {
            self.output.topics.data = self.topicsArray
        }
    }
}
