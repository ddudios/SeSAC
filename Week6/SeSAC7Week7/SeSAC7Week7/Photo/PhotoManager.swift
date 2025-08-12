//
//  PhotoManager.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import Foundation
import Alamofire

final class PhotoManager {
    
    static let shared = PhotoManager()
    
    private init() { }
    
    func getOnePhoto(id: Int, success: @escaping (Photo) -> Void) {
        let url = "https://picsum.photos/id/\(id)/info"
        
        AF.request(url).responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPhotoList(success: @escaping ([PhotoList]) -> Void) {
        let url = "https://picsum.photos/v2/list?page=1&limit=20"
        
        AF.request(url).responseDecodable(of: [PhotoList].self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
