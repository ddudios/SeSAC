import UIKit

class Guild {
    var name: String
    weak var owner: User?  // 길드장 유저
    
    init(name: String) {
        self.name = name
        print("Guild Init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

class User {
    var name: String
    weak var guild: Guild?  // 가입 할수도있고 안할수도있고
    
    init(name: String) {
        self.name = name
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

//var sesac = Guild(name: "새싹")
//var user = User(name: "미묘한도사")
/**
 새싹 공간에 길드 저장, 유저 공간에 유저 저장
 init시점에 인스턴스 생성
 Guild Init
 User Init
 */

//var sesac: Guild? = Guild(name: "새싹")
//var user: User? = User(name: "미묘한도사")
//print(sesac?.name)
//sesac = nil  // VC 기준 화면이 사라짐
//print(sesac?.name)
/**
 Guild Init
 User Init
 Optional("새싹")
 Guild Deinit
 nil
 
 - 인스턴스 생성시 공간이 만들어지고 Init호출
 - nil이면 메모리 공간에서 사라지고 Guild Deinit -> sesac?.name 공간을 더이상 찾을 수 없어서 nil 프린트
 */

//var sesac: Guild? = Guild(name: "새싹")
//var user: User? = User(name: "미묘한도사")
//print(sesac?.name)
//print(sesac?.owner)
//
//sesac?.owner = user
//print(sesac?.owner)
//
//sesac = nil
//print(sesac?.name)
//print(sesac?.owner)
/**
 Guild Init
 User Init
 Optional("새싹")
 nil
 Optional(__lldb_expr_9.User)
 Guild Deinit
 nil
 nil
 
 - 새싹, 도사 인스턴스로 공간을 차지하고 있음
 - 새싹 이름: 새싹
 - 길드장: nil
 - 새싹의 오너에 유저 인스턴스를 줌
 - 새싹에 nil을 주니까 Deinit이 호출되고 그 뒤는 nil로 떨어짐
 
 ARC
 - 인스턴스 생성할 때 레퍼런스를 +1
 - nil로 설정하면 -1
 */

//var sesac: Guild? = Guild(name: "새싹")  // 인스턴스 생성시 RC+1 (바라보고 사용하고 있기 때문에)
//sesac = nil  // RC-1 (0이 되면 메모리에서 내려감)
//var user: User? = User(name: "미묘한도사")  // RC+1
//user = nil  // RC-1
/**
 Guild Init
 Guild Deinit
 User Init
 User Deinit
 */

// 순환 참조
//var sesac: Guild? = Guild(name: "새싹")  // RC+1
//var user: User? = User(name: "미묘한도사")  // RC+1
//
//sesac?.owner = user  // RC+1 => 2
//user?.guild = sesac  // RC+1 => 2
//
//sesac = nil  // -1
//user = nil  // -1
/**
 Guild Init
 User Init
 */

//var sesac: Guild? = Guild(name: "새싹")  // RC+1
//var user: User? = User(name: "미묘한도사")  // RC+1
//
//sesac?.owner = user  // RC+1 => 2
//user?.guild = sesac  // RC+1 => 2
//
//sesac?.owner = nil  // RC-1 => 1
//user?.guild = nil  // RC-1 => 1
//
//sesac = nil  // RC-1 => 0
//user = nil  // RC-1 => 0
/**
 순차적으로 다 끊어낸 상황이기 때문에 Deinit까지 잘 호출됨
 Guild Init
 User Init
 Guild Deinit
 User Deinit
 */

//var sesac: Guild? = Guild(name: "새싹")  // RC+1
//var user: User? = User(name: "미묘한도사")  // RC+1
//
//sesac?.owner = user  // RC+1 => 2
//user?.guild = sesac  // RC+1 => 2
//
//sesac = nil  // -1
//user = nil  // -1
//
//sesac?.owner = nil
//user?.guild = nil
/**
 순서가 바뀌면 sesac, user를 찾을 수 없어서 내부의 것을 끊어낼 수 없음
 Guild Init
 User Init
 */

//var sesac: Guild? = Guild(name: "새싹")  // RC+1
//var user: User? = User(name: "미묘한도사")  // RC+1
//
//sesac?.owner = user  // RC+0 => 1
//user?.guild = sesac  // RC+0 => 1
//
//sesac = nil  // -1 => 0
//user = nil  // -1 => 0

/**
 위험이 될 것 같은 요소에 weak
 Guild Init
 User Init
 Guild Deinit
 User Deinit
 
 위험될 것같은 요소를 어떻게 판단?
 - 찝찝하거나 Deinit이 호출되지 않는 부분에 그냥 weak를 붙임 (보통 습관적으로 해결)
 */

// 실제 앱에서 어떻게 쓰이는지
class Person {
    let name: String
    
//    var introduce =
//        print("저는 고래밥입니다.")
//    }
    
    lazy var introduce1 = { [weak self] in  // 같은 시점 생성 -> lazy
        guard let self = self else { return }
        print("저는 \(self.name)입니다")  // self: RC+1 (name을 어떻게든 갖고있어야겠다고 해서)
    }
    
    init(name: String) {
        self.name = name
        print("Person Init")
    }
    
    deinit {
        print("Person Deinit")
    }
}

//var person: Person? = Person(name: "jack")  // RC+1
//person?.name  // jack
//person?.introduce()
//person = nil  // RC-1
//person?.name  // nil (메모리에서 공간이 사라지니까, 접근 못함)
//person?.introduce()  // nil
/**
 Person Init
 저는 고래밥입니다.
 Person Deinit
 */

//var person: Person? = Person(name: "jack")  // RC+1
//person?.name  // jack
//person?.introduce1()
//person = nil  // RC-1
//person?.name  // nil (메모리에서 공간이 사라지니까, 접근 못함)
//person?.introduce1()  // nil
/**
 Person Init
 저는 jack입니다
 
 - 실행할 수는 없는데 Deinit이 찍히지 않음 (self키워드 때문)
 - 보통 습관적으로 [weak self] in self를 사용해도 +1을 시키지 말자
 - 약하게 잡고 있겠다, self가 없는 상황도 있기 때문에 옵셔널로 self?.
 - 이 옵셔널을 해결하기 위해서 guard let self = self else { return }
 Person Init
 저는 jack입니다
 Person Deinit
 */

// 메모리 누수가 발생할 수 있는 또 다른 상황
protocol MyDelegate: AnyObject {
    func sendData()
}

class MainVC: MyDelegate {
    
    // (중복뷰일때)커스텀뷰를 놓는 상황
    lazy var customView = {
        let view = DetailView()  // TableView
        view.jack = self  // 값전달 Delegate, DataSource RC+1
        return view
    }()
    
    func sendData() {
        print("안녕하세요")
    }
    
    deinit {
        print("MainVC Deinit")
    }
}

class DetailView {
    
//    var jack: MainVC?  // 너무 큰 것을 옮김 -> Protocol 활용
    weak var jack: MyDelegate?  // 값전달하기 위해 프로토콜 활용, 역전달할 때 weak를 써야 한다
    // weak는 클래스의 인스턴스나, 참조 타입을 해결하기 위해 나온 키워드
        // 근데 protocol은 구조체, 열거형, 클래스에서 사용 가능 -> AnyObject로 class에서만 사용 가능한 프로토콜이다라는 지칭이 필요함
    
    func dismiss() {
        jack?.sendData()  // didSelectRowAt, CellForRowAt
    }
    
    deinit {
        print("DetailView Deinit")
    }
}

var view: MainVC? = MainVC()
//retain()  // MRC 수기로 작성
view = nil  // dismiss
//release()
/**
 # self 키워드 없었을 때
 MainVC Deinit
 DetailView Deinit
 */

/**
 # self 키워드 있을 때
 MainVC Deinit
 */
