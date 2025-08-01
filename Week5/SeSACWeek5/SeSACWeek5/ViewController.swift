//
//  ViewController.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 7/29/25.
//

import UIKit
import SnapKit

//동기와 비동기
class ViewController: UIViewController {
    
//    let a = APIKey()
    // .찍어서 가져올 거니까 불필요한 공간을 만들 필요가 없다
    // 코드의 의도전달시 다른 사람은 이렇게 사용할 수도 있다
    
    let imageView = UIImageView()
    let button = UIButton()
    let s = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
//        serialSync()
//        serialSync1()
//        serialAsync()
//        concurrentAsync()
//        concurrentAsync1()
//        concurrentSync()
//        globalQualityOfService()
//        globalQualityOfService1()
        dispatchGroupA()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        showAlert(title: "상품을 좋아요에 등록할까요?", message: "이 상품이 만족스러우신가요?", ok: "저장", vc: self)
//        showAlert(title: "상품 삭제", message: "상품을 삭제할까요?", ok: "삭제")
//        showAlert(title: "테스트", message: "얼럿이 떴습니다", ok: "배경바꾸기") {
//            print("버튼을 클릭했어요")
//            self.view.backgroundColor = .yellow
//        }
    }
    
    // KingFisher를 안쓰면 어떻게 사진을 가져오는지? 웹에 있는 주소를 로드해줄 수 있다
        // 웹에 있는 이미지를 0101로 바꿔서 UIImage로 넣는다
    // 알바생(Thread)을 여러명 두면 해결이 될 수 있다
        // 한 명이 일하게 두는 것이 아니라 바쁜 일들이나 중요한 일들은 다른 사람이 할 수 있도록 알바생을 여러 명 두면 코드를 더 빠르게 끝나는 형태로 만들어 볼 수 있다
    @objc func buttonClicked() {
        
        // 그동안 자주 사용했던 이미지 이니셜라이저
//        imageView.image = UIImage(named: <#T##String#>)  // Asset
//        imageView.image = UIImage(systemName: <#T##String#>)  // SF Symbol: 애플이 제공하는 이미지 사용
        
        // URL을 통해서 어떻게 이미지를 보여줄 수 있을지
            // 결국 Kingfisher도 애플에서 뭔가 할 수 있게 해주는 거니까
        // 결국에 시각적으로 보이는 이미지도 0101로 바꿔야 해서 Data타입으로 변환을 해줘서 넣게 된다
//        UIImage(data: <#T##Data#>)
        
        // 메인은 코드를 실행하다가 다른 친구들에게 맡기고 일을 마침
        print(#function)
        // URL 생성: String -> URL
        // URL은 무조건 옵셔널 타입
            // 지금은 정상적으로 동작하지만, 중간에 이상한 문자열을 넣게 되면 유효하지 않은 링크가 될 수 있고, 아무 글자나 넣으면 그게 URL로 바뀔 수는 없다
            // 안될 수 있는 상황이 너무 많아서 디폴트로 옵셔널 타입이 된다
            // 지금은 문제 없으니까 !사용
        let url = URL(string: "https://apod.nasa.gov/apod/image/2507/Helix_GC_2332.jpg")!
        print("1111")
        
        // 바쁜 일들은 다른 친구들에게 맡김
        DispatchQueue.global().async {
            
            // URL을 통해서 다운로드를 받아오는 형태처럼 0101로 바꿔서 담음
            let data = try! Data(contentsOf: url)  // URL을 넣을 수 있는 기능
            print("2222")
            DispatchQueue.main.async {
                
                // 그 0101을 통해서 애플한테 이미지로 보여달라 요청
                self.imageView.image = UIImage(data: data)
            }  // 이미지가 오지 않아도 스위치는 부드럽게 사용된다
        }
        print("3333")
        // 닭: print, url, data변환, image, print 혼자 다 하려고 하니까 병목현상
        // 작업이 금방금방 되는 코드는 다른 알바생한테 보낼 필요는 없을 것 같은데
        // data변환, image는 다른 알바생한테 global().async로 맡김
    }
    
    func configureView() {
        view.backgroundColor = .yellow
//        a.  // 내부에 인스턴스가 없어서 어쩌피 꺼내올 것도 없다
        print(APIKey.kakaoKey)  // git에 이 내용은 보이지만, 안에 무슨 내용이 있는지 깃에서는 못봄
        navigationItem.title = "네비게이션 타이틀"
        
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(s)
        
        button.setTitle("클릭하기", for: .normal)
        imageView.backgroundColor = .red
        
        // 킹피셔 안쓰고 코드로 이미지 부르는 법
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        
        button.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        // 스위치를 일반적으로 사용했을 때 동작이 다름
            // 원래는 스위치를 클릭하면 빠르게 움직이는데
            // 버튼을 클릭하고 나면 스위치를 아무리 클릭하더라도 스위치가 움직이지 않음
            // 이미지가 이미지뷰에 뜨고 난 다음에 스위치가 잘 움직이다가
            // 다시 버튼을 클릭하면 스위치를 아무리 클릭해도 움직이지 않는다
        s.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
    func serialSync() {  // 동기 + 직렬
        print("START", terminator: " ")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
        // START -> 1...100 -> 101...200 -> END
        // 닭만 힘든 코드: END찍히기 위해서 앞의 모든 일 닭이 함
    }
    
    func serialSync1() {  // 동기 + 직렬
        print("START", terminator: " ")
        
        // 작업이 끝날 때까지 당겨서 일을 하는 것이 아니라 내가 하던 대로 (다른 알바생의 일이 끝날 때까지 다음 코드를 실행하지 않겠어)
        // 직렬: 한 애한테 몰아주는 것인데, 닭한테 몰아줌
        DispatchQueue.main.sync {  // 동시 + 직렬
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    
    // 메인은 일을 다른 알바생한테 보내놓고 다른 알바생 일이 안끝나더라도 내 할일을 수행하는 형태 (비동기)
    // 다른 알바생한테 골고루 주지 않고 매니저(큐)가 갖고 있는 일을 한 알바생한테 몰아주겠다 (직렬)
    func serialAsync() {  // 비동기 + 직렬
        print("START", terminator: " ")
        
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
        // START -> 101...200 -> END -> 1...100
        // 1...100은 다른 알바생, 안끝나도 괜찮으니까 내가 할 일 당겨서 해야겠다
        // 매니저가 갖고 있는 일이 안끝나도,
        // 작업자 입ㅂ장에서 직렬로 보내야지, 골고루 분배하는 것이 아니라 하나의 알바생에게 몰아야지 - 다시 닭벼슬한테
        // 직렬 = main
        // 그래서 할 일이 마지막으로 보내는 것이 mian.async
    }
    
    // 닭벼슬(메인)은 일을 다른 알바생한테 보내놓고 다른 알바생 일이 안끝나더라도 내 할일을 수행하는 형태 (비동기)
    // 매니저(큐)가 담당하는 일을 여러 알바생한테 골고루 분배를 해주겠다.. 나는 착하니까..
    func concurrentAsync() {  // 비동기 + 동시
        print("START", terminator: " ")
        
        // global() == 동시
        // async == 비동기
        DispatchQueue.global().async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
        // START -> 101...200 -> END -> 1...100
        // 큐한테 일을 보내놓고 들어간 일이 안끝나도 내할일을 하겠다고 수행
        // 워낙 작업량이 적어서 START ~END까지 (11:30)
        // 알바생한테 일을 맡기기도 전에 작업이 끝나기 전에 닭벼슬이 일을 끝냄
        // 1~100 출력 기능을 알바생이
    }
    
    func concurrentAsync1() {
        print("START", terminator: " ")
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
        // START 1 50 101 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 2 51 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 END
        // 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 81 82 80 83 84 86 87 88 89 85 91 92 93 94 95 96 97 90 99 98 100
        // print 실행 -> 1...103 뒤죽박죽 -> END -> 104...200
        // 1~100 다른 알바생한테 분배, 이 작업이 안끝나더라도 내 할일을 할게, 101~103정도는 실행되고 있다
        // 누구한테 주는지는 모르지만 골고루 분배하다보니까
    }
    
    // 동기 + 동시
    // 작업을 보내놓고 보낸 작업이 끝날 때까지 기다렸다가 (이때 약간은 놀 수 있음) 다음 작업 (동기)
        // 닭벼슬은 일이 다 끝날때까지 기다렸다가 내 할일을 나중에 하겠어...
    // 여러 쓰레드에 골고루 분배 (동시)
        // 다른 알바생한테 고루고루 일을 나눠주겠어.
    // 실질적으로 메인쓰레드(닭벼슬)이 수행하게 되는 구조
    func concurrentSync() {
        print("START", terminator: " ")
        
        DispatchQueue.global().sync {  // 실질적으로 메인이 하는 것과 똑같음
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
        // START -> 1...100 -> 101...200 -> END
        // 동시에 동기로 보내는 중
        // 1..100 수행하는 것을 일단은 큐한테 보냄
        // 이 작업이 다 끝날때까지 101출력은 하지 않음
        // 동시에 실행해달라고 했기 때문에 다른 알바생한테 보냄
        // START프린트 하고 일을 보냈으니까
        // 101 ~ END
        // 다른 알바생이 일할 수 있게 해줘라고 보내놓고, 이 시간에 닭은 그냥 놀음
    }
    
    func globalQualityOfService() {
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        for i in 201...300 {
            print(i, terminator: " ")
        }
        // 1..100 -> 101...200 -> 201...300
    }
    
    // 다 다른 알바생한테 보낼 것
    // 여러 알바생이 일을 고루 나눠 하니까 작업은 더 빨리 끝날 수 있어서 좋지만,
    // 100, 200, 300 중 뭐가 마지막에 끝나는 지 아는 것은 어렵다
    // 필요성: 출력 다 끝나고 새로운 화면 보여주려는데 세번 띄워줄 수는 없다, 다 끝나고 present하면 다른 알바생한테 다 보내고 마지막에 있는 코드가 마지막에 실행되는 것이 아니라 메인이 먼저 일을 끝냄
    // 마지막이 언제 끝날 지 알기 위해서는 어떻게 해야할까? 얼럿, 백그라운드, 화면전환 등)
    // 이 키워드는 DispatchGroup(내일)
    
    // 여러 알바생들을 굴려서  작업을 빠르게 만드고 싶은데, 조금 더 빠르게 끝나거나 (더 똑똑한 알바생 뽑기)
    func globalQualityOfService1() {
        // 비동기 + 동시
        // 닭벼슬이 하는 일 X
        // global: 골고루
        
        print("START")
        DispatchQueue.global(qos: .background).async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        print("END")
        // START -> END
        // 중구난방으로 출력 100번이 먼저 끝날 때도, 200번이 먼저 끝날 때도, 300번이 먼저 끝날 때도 있을 것이다
        // 순서대로 실행된다면 뭐가 언제 끝날 지 알지만
        // 여러 명이 동시에 일하면 어느 시점에 뭐가 먼저 끝날 지 알 수 없다는 한계
        // 100번이 먼저 끝날 지 300번이 먼저 끝날지 알 수 없다
    }
    
    // 넷플릭스, 쿠팡플레이 등
    // 앱에서 넷플릭스가 추천 컨텐츠, 다시보기 등 수많은 섹션들로 앱이 구성되어 있다
    // 이런 내용들을 가져올 때 한 번에 통신을 해주면 좋겠지만
    // 추천, 다시보기, 오늘의 신작, 다음주 신작 등 섹션이 10개가 있다고 가정해보면
    // 추천 API콜 한번, 다시보기 API콜 한번, 오늘 API콜 한번, 다음주 API 콜 한번, ... API통신을 많이 해야하는 형태로 꾸려질 수 있다
    // 1~10까지 섹션이 네트워크 통신을 통해서 데이터를 받아와야 된다고 하면 10번보다는 1번이 빨리 받아져야 한다. 왜냐하면 사용자가 스크롤하지 않을 수도 있다
    // 그러니까 뒤에 있는 내용들은 조금 천천히 로드되도 괜찮은데, 앱에서 상단에 떠있는 친구들은 사용자가 무조건 보는 화면이니까
    // 우리가 타이밍을 조절할 수 있다면 아래의 내용보다는 상단의 내용에 대한 데이터 응답이 빨리 와서 빠르게 위에서부터 차곡차곡 내용들을 보여주는게 좋을 수도 있겠다
    
    // 반복문 안에 넣어서 빗스한 테스크를 많이 만듦. 그러면 반복문을 돌면서 100개의 테스트
    func globalQualityOfService2() {
        // 비동기 + 동시
        // 닭벼슬이 하는 일 X
        // global: 골고루
        
        print("START")
        
//        DispatchQueue.main.async {
//            <#code#>
//        }
        
        DispatchQueue.global(qos: .background).async {  // 천천히 돼도 괜찮아
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        // 마지막에 끝났네
        DispatchQueue.global(qos: .userInitiated).async {  // 가장 높은 우선순위
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        print("END")
    }
    
    // Dispatch Group
    func dispatchGroupA() {
        // 방법1) 그룹에 묶는다 ( Swift Concurrency 구문에서 Task Group과 비슷한 로직)
            // .async(group: group)
            // 동기 메서드에 적합함 (네트워크 통신에는 적합하지 않음)
        
        // 그룹핑 - 큐가 일을 보내놓고 끝내는 것이 아니라 다 했는지 체크
            // 어떻게 체크하냐면, async로 다른 알바생한테 어떻게든 보내고 기록을 해둔다
            // 하나의 group에 4개의 알바생 등록
            // 다른 알바생한테 일을 맡길 때 같은 그룹임을 DispatchGroup()이 알고 있고, 이 그룹에서 모든 일들이 끝나면
            // 이 상수에 notify메서드가 있다
        let group = DispatchGroup()
        
        print("AAAAA")
        DispatchQueue.global().async(group: group) {
            // 지금은 한 알바생이 다 해서 그렇지
            /*
            for i in 1...50 {
                print(i)
            }*/
            // 하청을 부리면
            print("1")
            DispatchQueue.global().async(group: group) {
                for i in 1...50 {
                    print(i)
                }
            }
            print("2")
        }
        print("BBBBB")
        DispatchQueue.global().async(group: group) {
            for i in 51...100 {
                print(i)
            }
        }
        print("CCCCC")
        DispatchQueue.global().async(group: group) {
            for i in 101...150 {
                print(i)
            }
        }
        print("DDDDD")
        DispatchQueue.global().async(group: group) {
            for i in 151...200 {
                print(i)
            }
        }
        print("EEEEE")
        
        // A 작업 B 작업 C 작업 D 작업 E -> 큐에 작업들을 보내고 -> 알바생에게 골고루 작업이 보내짐
        // AAAAA BBBBB CCCCC DDDDD EEEEE 51 52 53 151 152 1 2 101 102 ... 100
            // 처음 실행 끝값은 100, 다음 실행 끝 값은 200, 이렇게 끝나는 타이밍이 매번 다르다
        
        // 끝났다는 타이밍을 어떻게 알 수 있을까?
            // 일들을 그룹으로 묶는다 (한 번 그룹핑을 해준다)
            // 4개의 일을 맡겼으면 완료하면 체크해서 4개 모두 체크되면 신호를 보낼 수 있는 도구가 있다
        
        // 보통 클로저의 형태로 짧게 쓴다 .notify(queue: ) { }
        // 누가 먼저 끝나든, 항상 notify가 가장 마지막에 실행되기 때문에 마지막 시점을 트리깅할 수 있다
            // 4명의 알바생 중 누가 먼저 끝날 지는 모르겠지만 어쨌든 notify가 가장 마지막에 실행되기 때문에, 이 때 어떤 작업들을 할 수 있냐면 테이블뷰 갱신, 화면전환 등의 형태로 개선해볼 수 있다
        group.notify(queue: .main) {
            print("끝났습니다")
        }
    }
    
    func dispatchGroupB() {
        
    }
}
