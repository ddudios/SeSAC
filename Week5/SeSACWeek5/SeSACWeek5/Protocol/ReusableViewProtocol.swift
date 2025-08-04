//
//  ReusableViewProtocol.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 8/4/25.
//

/*
 UIViewController, Cell, Xib, 화면 전환 등 모든 요소들이 대부분 Identifier가 필요하다
 모든 요소들에 대해서 그냥 기본적으로 static let identifier를 가지고 있으면 어떨까?
 */


import UIKit

// 없어도 돌아가지만 누가 잘못해서(같은 기능이지만 다른 이름을 사용한다거나) 수정하지 않게, 시간이 지나서 못알아보지 않게 굳이 명세
// 최소한의 주석만으로 커뮤니케이션 가능
protocol ReuseableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReuseableViewProtocol {
    
    // 어떤 UIViewController든 이 기능 사용 가능
    func idTest() {
        print(self)
        print(String(describing: self))
    }
    // <SeSACWeek5.TransitionViewController: 0x104834c00>
    // <SeSACWeek5.TransitionViewController: 0x104834c00>
    
    // ViewController에서 이미 identifier에 대해서 가지고 있는 형태로 만들고 싶다
    // 인스턴스 메서드면 계속 생성이 되겠지만, 타입을 활용하면 한 공간에서 재사용할 수 있는 구조
    func identifier() -> String {
        return String(describing: self)
    }
    
    // extension은 인스턴스 프로퍼티는 사용할 수 없음
    // static let은 let으로 고정 -> 연산프로퍼티면 각각의 컨트롤러마다 변경해 사용할 수 있음
    // 매개변수를 활용하지 않으니까 연산프로퍼티
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseableViewProtocol {
//    static func identifier() -> String {
//        String(describing: self)
//    }

    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView: ReuseableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
//    static func identifier() -> String {
//        String(describing: self)
//    }
}
