//
//  Resource.swift
//  SeSAC7Week3
//
//  Created by Suji Jang on 7/15/25.
//

import UIKit

struct Color {
//    let jackRed = UIColor.red  // 인스턴스 저장 프로퍼티: 인스턴스 접근 여부, 공간을 가지고 있는지 여부(=이 있으면 저장 프로퍼티)
    static let jackRed = UIColor.red  // 타입 저장 프로퍼티: 인스턴스 관점, 직접 컬러 보유 여부(=이 있으면 저장 프로퍼티)
    let jackBlack = UIColor.black
}

struct Image {
    static let star = UIImage(systemName: "star.fill")
}

// 보통 리소스는 한 군데 저장해놓고 가져다 쓰는게 좋기 때문에 struct로 만들어놓고 사용한다
// 계속 저장될 필요 없다면, 고화질의 이미지가 데이터 영역에 1G의 데이터를 차지하고 있다면 앱 종료 전까지 계속 데이터를 먹는다
    // struct는 데이터 영역에 저장되고,
    // 그런데 이게 배경화면이라 100명중 100명이 본다면, 여기 놓는게 맞을 수 있다
    // 숨겨져 있어서 100명 중 1명이 본다면, 여기에 놓으면 데이터가 낭비된다
// static은 호출하지 않으면 데이터 영역에 올라가지 않는다 (캡쳐 12:01)
    // 어떤 화면에 static이 선언되어 있어서 그 화면을 띄우지 않으면 데이터 영역에 올라가지 않는다
