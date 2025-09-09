//
//  LocationViewController.swift
//  SeSac7HardwareDatabase
//
//  Created by Suji Jang on 9/9/25.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation  // 위경도에 대한 정보가 다 여기 들어있음
// 모든 프레임워크가 가져가는 구조가 동일함: (패턴들이 유사함)
    // 1. 프레임워크가 있고

class LocationViewController: UIViewController {
    
    let mapView = MKMapView()
    let button = UIButton()
    
    // 2. 위치 매니저 생성: 위치에 대한 대부분을 담당 - 매니저가 할 일이 정말 많음 (권한, 신호 받기 등의 기능은 protocol에 들어있음)
//    let locationManager = CLLocationManager()  // CL: 프레임워크에 대한 prefix
    lazy var locationManager = CLLocationManager() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        // 4. 프로토콜 연결
        locationManager.delegate = self  // tableView 구조와 유사 (어떤 프레임워크를 사용하든 비슷한 구조로 이루어져 있다)
        
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(button.snp.top)
        }
        
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked() {
        
        DispatchQueue.global().async {
            
            // 1) iOS 위치 서비스 활성화 여부 확인
            // 사용자가 아이폰 전체 접근을 막아놓으면 접근할 수조차 없음
            // 앱의 권한과 상관없이 아이폰 설정의 토글
            if CLLocationManager.locationServicesEnabled() {
                print("권한 허용 가능한 상태, 권한 띄울 수 있음")
                // 클릭시 보라색 오류: 사용은 되지만 UI관련된 메서드라 Main에서 하면 안된다는 동작하는 코드 필요
                // Scheme > edit scheme > Diagnostics > 체크
                // 원래 보라색 영역이 아니었는데 보라색으로 업데이트되면서 잘되던 서비스가 터짐
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization()  // 현재 위치를 조회할 수 있는지
                }
                
            } else {
                print("아이폰 위치 서비스가 꺼져 있어서, 위치 권한 요청을 할 수 없습니다.")
            }
        }
    }
    
    // 2) 현재 사용자 권한 상태 확인 후 얼럿 띄우기, 항상 얼럿이 뜨는 것은 아님
        // 얼럿 띄우는건 UI, UI는 메인에서 -> 이 함수는 메인에서 동작하도록 바꿔줘야함
    func checkCurrentLocationAuthorization() {  // 현재 위치를 조회할 수 있는 권한
        
        var status: CLAuthorizationStatus        /**
                                                  // 권한 허용에 대한 처리를 분기 처리할 수 있는 열거형
                                                  // 열거형의 케이스로 권한을 나누게 된다
                                                  case notDetermined = 0  // 사용자가 허용/거부 등 아무것도 설정하지 않은 상태: 보통 앱을 처음 실행했을 때
                                                  case restricted = 1  // 자녀 보호모드: 사용자가 권한을 바꿀 수 없는 상태
                                                  case denied = 2  // 거부한 상태
                                                  
                                                  @available(iOS 8.0, *)
                                                  case authorizedAlways = 3
                                                  
                                                  @available(iOS 8.0, *)
                                                  case authorizedWhenInUse = 4
                                                  */
        // 사용자가 권한을 허용하고 있는지/아닌지 가 iOS 14 기준에 따라서 체크할 수 있는 메서드가 다름
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            print("권한이 아직 결정되지 않은 상태로, 여기서만 권한 문구를 띄울 수 있음.")
            
            // 앱을 사용하는 동안 허용
            // 권한 여부 확인 (허용, 거부, 결정X): notDetermined 상황에서 request가 일어난다
            locationManager.requestWhenInUseAuthorization()
            /**
             앱을 실행하면, locationManagerDidChangeAuthorization(:)메서드가 일단 실행된다
             > 버튼 클릭시, GPS가 ON이 된 상태인지 먼저 확인 > 사용자의 권한 확인(허용/거부/결정X)해서 분기처리를 통해서 > 아직 결정되어 있지 않으면 허용 문구 띄움
               - 권한 허용 가능한 상태, 권한 띄울 수 있음 (notDetermined상태이기 때문에 request를 통해서 권한 문구 띄움)
               - 권한이 아직 결정되지 않은 상태로, 여기서만 권한 문구를 띄울 수 있음.
             > 한 번 허용 클릭시, 권한 상태가 변경되었다는 locationManagerDidChangeAuthorization(_:) 메서드 실행됨 (notDetermined상태에서 > authorizedWhenInUse상태로 변경되었기 때문에 이 메서드 실행됨)
             */
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters  // 정확도에 대해서 TenMeters를 가져옴
            // 사용자가 10미터정도 이동했다는 것이 감지되면 didUpdateLocations를 실행시켜주겠다
                // 위치를 성공적으로 조회했을 때 실행되는 didUpdateLocations메서드는 고정적인 위치일 때에는 한번만 실행되지만 어떻게 로직을 작성하느냐에 따라 여러번 호출될 수도 있다
            // 위치가 바뀌면 위치마다 사용자한테 위치가 달라졌으니까 새로운 위경도값을 주는 코드가 필요할텐데
                // 그 빈도를 얼만큼 제어를 할건지가 accuracy를 통해서
                // 10미터 달렸다 싶으면 위경도를 계속 업데이트해줌
            // 그래서 잘못 코드를 쓰면 GPS는 계속 일을 하고 있는 상태가 된다
                // 나는 날씨만 가져오고 싶었는데, 사용자가 달리니까 매 초마다 신호가 오고 있고, 베터리 소모 증가로 발열
                // 위치의 용도는 달라지지 않았는데 위경도는 계속 조회됨
            
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // 아이폰에서 동작할 때 최적의 업데이트 시점과 애플워치가 동작될 때 최적의 시점이 달라서 기기마다 베스트라고 생각하는 애플의 기준을 사용하겠다
            // 테스트에서는 10M가 적합 / 실제 서비스에서는 Best가 적합
            
//        case .restricted:  // 아이폰을 자녀한테 주면 권한에 대해서 제어할 수 있음
            
        case .denied:
            print("사용자가 거부한 상황, iOS 설정 창으로 이동하라는 얼럿 띄우기")
            // 사용자의 권한이 거부되어 있다면, 이미 거부된 상황이기 때문에 풀어줄 수 있는 방법은 없고, 사용자가 직접 설정창으로 이동시켜주는 방향밖에 없음
            
        case .authorizedWhenInUse:
            print("사용자가 허용한 상태이기 때문에 위치 정보를 얻어오는 로직을 구성할 수 있음.")
            // 이미 허용이 되어 있다면 굳이 권한을 확인해달라고 굳이 띄울 필요 없음
            
            // didUpdateLocations를 실행시켜줄 수 있음
                // 어느 상황부터 위치를 받아와야 하는지를 모르기 때문에 trigger를 줌
                // 이제부터 위치 찾아오는 거야! 라는 start메서드가 없으면 위치 정보를 얻어올 수 있는 메서드를 조회할 수 있는 방법은 존재하지 않는다
            locationManager.startUpdatingLocation()
            
//        case .authorized:  // iOS 8.0 미만에서 사용하던 거라 요즘 사용할 일은 없음
            
        default: print(status)
        }
    }
}

// 3. 위치 프로토콜 (여러가지 기능 담당: 채택하면 연결시켜줘야 함)
extension LocationViewController: CLLocationManagerDelegate {
    
    // didUpdateLocations: 위치를 성공적으로 조회한 경우
        // 이 메서드에서 위경도가 옴
        // 이 메서드를 실행하려면 실행시켜달라는 메서드가 필요하다: .authorizedWhenInUse시점에 startUpdatingLocation()실행
        // 사용자가 위치 동의 > 필요한 시점에 어디에 있다를 알려주는 메서드
        // 현위치로 이동 버튼을 누르면 - 이 메서드를 탐
    // 코드 구성에 따라서 여러 번 호출이 될 수도 있다.
        // 경로 찍기에서 사용 가능
        // 움직이고 있는 상황에서 여러 번 호출하거나, 코드를 잘못 작성하면 계속 실행됨
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // CLLocation에 들어있는 정보: (사용자의 위치를 생각했을 때) 위경도값, 등고선, 해수면
        print(#function)
        /**
         이제 버튼을 다시 눌렀을 때는 사용자가 이미 허용한 상태이기 때문에, 권한 문구는 뜨지 않음
         - 권한 허용 가능한 상태, 권한 띄울 수 있음
         - 사용자가 허용한 상태이기 때문에 위치 정보를 얻어오는 로직을 구성할 수 있음.
         - locationManager(_:didUpdateLocations:)
         - Optional(__C.CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417))
         */
        
        // 여기에서 로직: 현재 위치에 대한 날씨 정보 API 요청(조회), 지도 센터 이동, 지도에 폴리라인 그려주기, 지도에 크러스터링 찍기 등
        
        print(locations.first?.coordinate)  // 현재 위치 위경도 좌표 - coordinate: CLLocationCoordinate2D
        let region = MKCoordinateRegion(  // 타입 중에 중앙에 누구를 두고 위도와 경도의 거리를 물어보는 메서드
            center: locations.first!.coordinate,  // 위경도에 대한 값 (location 중에서 위경도값을 쓰겠다)
            latitudinalMeters: 500,  // 축척
            longitudinalMeters: 500
        )
        
        // 지도 프레임워크 코드 - 지도에서 센터 맞춰줌
        // 위치를 성공적으로 조회했다면 > 그 위치에 지도를 놓고 싶어
        mapView.setRegion(region, animated: true)
        // animated: true -> 어지러울 수 있음
        
        /**
         - 러닝앱: didUpdateLocations는 자주 해주는게 맞음
         - 날씨앱: 빈도가 낮아도 상관없음
         - 부동산앱: 보통 현재 위치보다는 내가 검색하고 싶은 지역들이 필요하다보니까 빈도는 낮음
         */
        // 위치에 대해서 핸들링을 할 때, 정확도를 어느정도 체크할 것인가 kCLLocationAccuracyNearestTenMeters도 중요하고, 이 부분이 설정되어있지 않다고 하더라도 현 위치가 여러 번 호출될 수 있음
        // 그렇기 때문에 지금부터 조회를 해달라는 start메서드를 사용해 요청을 했으면, 한 번 받았으면 이제 안해도 된다고 명세해주는 것이 필요하다
        // 이 앱은 한 번만 위치를 얻어오면 되니까 더 이상 위치를 안가져외도 된다는 stop메서드를 써주는 것 (이 필요한 서비스가 있을 수 있고 필요하지 않은 서비스가 있을 수도 있다)
        // start 메서드를 썼으면, 더이상 위치를 얻어올 필요가 없는 시점에서는 stop을 써주어야 함
        locationManager.stopUpdatingLocation()
        // 이 메서드를 빼먹으면, 어떻게 로직을 짜는지에 따라서 GPS가 내 정보를 계속 트리깅할 수 있어서 stop메서드를 쓰는 게 꼭 필요하다
        // 이 메서드를 안 써도 사용자는 모르지만, 이 앱 쓰면 발열 심하더라 정도는 느낄 수 있음
        // 이 메서드를 사용하면 아무리 달리고 있는 상황이여도 여러 번 호출되지 않음
        // 이 메서드의 위치는 상황에 따라 바뀔 수 있음
    }
    
    // didFailWithError: 위치 조회를 실패한 경우 (권한 없을 때)
        // 실패했을 때의 메서드 (사용자 거부)
        // 현위치 버튼 클릭했을 때 - 얼럿이 뜸: 위치 권한 허용해야 한다
        // 현 위치인 서울역이 아닌 시청 등의 포멀한 곳을 잡아서 셋팅해주는 작업이 필요하다
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
        buttonClicked()
    }
    
    // 사용자 권한 상태가 변경된 경우 + locationManager Create (iOS14 이상)
    // locationManagerDidChangeAuthorization: 권한이 변경됐을 때
        // 네이버 지되 앱 사용하는 동안으로 권한 설정, 앱을 쓰고 있는 와중에 현위치 버튼을 누르면 현위치로 올 수 있는데, 권한 안함으로 설정 변경하면 현위치를 누르면 설정 > 개인정보 보호 권한 설정해줘라 얼럿 뜨는지 확인
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        
        // (iOS 14 이상에서) 권한 상태가 변경되었을 때, 권한을 체크해주는 메서드를 다 실행해줘야 한다
        buttonClicked()
        /**
         1. GPS 체크 > 권한이 변경되었을 때 실행되는 메서드가 버튼을 누르지 않더라도 buttonClicked()때문에 권한을 체크하고 > not yet이니까 .notDetermined 분기를 타서 request메서드를 통해 권한 문구 띄움
            - locationManagerDidChangeAuthorization(_:)
            - 권한 허용 가능한 상태, 권한 띄울 수 있음
            - 권한이 아직 결정되지 않은 상태로, 여기서만 권한 문구를 띄울 수 있음.
         2. 한 번 허용 클릭시,
         2-1. 권한 변경 메서드 locationManagerDidChangeAuthorization이 실행되면서, 이 메서드에는 다시 아이폰 GPS On 체크부터 하는 로직이 수행된다
           : 반복적으로 실행이 계속 수행됨 - 권한 바뀌었으니까 사용자가 위치 서비스를 끄지는 않았나? 부터 다시 체크해서 사용자가 한 번 허용했으니까 이번에는 switch구문이 허용 쪽으로 타면서 start메서드를 타면서 update로 위경도에 대한 정보를 얻어올 수 있다)
           : 권한이 바뀌었을 때, buttonClicked를 통해서 다시 위치 서비스가 켜져 있는지 CLLocationManager.locationServicesEnabled() 체크 + 현재 위치 서비스를 조회할 수 있는지 checkCurrentLocationAuthorization 체크
         2-2. 이번에는 .authorizedWhenInUse로 권한이 바뀌어서 현재 위치 정보를 얻어오는 로직을 구성할 수 있음
         2-3. start메서드 덕분에 Coordinate에 관련된 정보를 조회하는 didUpdateLocations메서드를 실행할 수 있음
            - locationManagerDidChangeAuthorization(_:)
            - 권한 허용 가능한 상태, 권한 띄울 수 있음
            - 사용자가 허용한 상태이기 때문에 위치 정보를 얻어오는 로직을 구성할 수 있음.
            - locationManager(_:didUpdateLocations:)
            - Optional(__C.CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417))
         */
    }
    
    // 사용자 권한 상태가 변경된 경우 (iOS14 미만)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}
