//
//  MapViewModel.swift
//  MVVMBasic
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation

// 합쳐보기
// input, output, 데이터가공 - 관점으로 좀 더 분리해보기
enum Category {
    case korean
    case western
}

class MapViewModel {
    let loadData = Observable(())
    let koreanFilter = Observable(())
    let filter = Observable(())
    
    let list: Observable<[Restaurant]> = Observable([])
    let korean: Observable<[Restaurant]> = Observable([])
    let western: Observable<[Restaurant]> = Observable([])
    
    init() {
        loadData.binding { _ in
            self.load()
        }
        
        koreanFilter.binding { _ in
            self.koreanRestaurantFilter()
        }
        
        filter.binding { _ in
            self.westernRestaurantFilter()
        }
    }
    
    private func load() {
        list.data = RestaurantList.restaurantArray
    }
    
    private func koreanRestaurantFilter() {
        for restaurant in RestaurantList.restaurantArray {
            if restaurant.category == "한식" {
                korean.data.append(restaurant)
            }
        }
    }
    
    private func westernRestaurantFilter() {
        for restaurant in RestaurantList.restaurantArray {
            if restaurant.category == "양식" {
                western.data.append(restaurant)
            }
        }
    }
}

