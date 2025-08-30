//
//  TopicViewController+Extension.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit

extension TopicViewController {
    static func createLayout() -> UICollectionViewLayout {
        
        // Item 고정 크기 정의 (각각의 셀)
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(190), heightDimension: .absolute(240)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 셀 간격 설정 (선택사항)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4)
        
        // Group 크기 정의 (아이템들을 묶는 단위)
        // 가로 스크롤: 세로로 여러 개 셀이 들어갈 수 있게 설정
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(194),    // 그룹의 가로 크기 (item width + 간격)
            heightDimension: .absolute(260)
        )
        
        // 세로 방향으로 아이템들을 배치하는 그룹 생성
        // subitems: 이 그룹에 들어갈 아이템 배열
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section 생성 및 가로 스크롤 설정
        let section = NSCollectionLayoutSection(group: group)
        
        // 가로 스크롤 활성화
        section.orthogonalScrollingBehavior = .continuous
        
        // 섹션 내부 여백 (선택사항)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 0, trailing: 0)
        
        // 고정 헤더 설정
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),  // 화면 너비의 100%
            heightDimension: .absolute(30)          // 헤더 높이 30포인트
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,  // 헤더 타입
            alignment: .top  // 상단에 배치
        )
        
        // 헤더를 화면 상단에 고정
//        header.pinToVisibleBounds = true
        
        // 헤더를 섹션에 추가
        section.boundarySupplementaryItems = [header]
        
        // 최종 레이아웃 반환
        return UICollectionViewCompositionalLayout(section: section)
    }
}
