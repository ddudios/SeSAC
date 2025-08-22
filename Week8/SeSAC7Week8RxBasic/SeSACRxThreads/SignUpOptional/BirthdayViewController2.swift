//
//  BirthdayViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum JackError: Error {
    case invalid
}

class BirthdayViewController2: UIViewController {
    
    let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    let infoLabel: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    let yearLabel: UILabel = {
       let label = UILabel()
        label.text = "2023년"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let monthLabel: UILabel = {
       let label = UILabel()
        label.text = "33월"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "99일"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
  
    let nextButton = PointButton(title: "가입하기")
    
    let disposeBag = DisposeBag()
    /*
//    let text = BehaviorSubject(value: "")
    // 빌드하자마자 ""가 왜 레이블에 들어가는 걸까?
    let text = PublishSubject<String>()  // 바로 bind되지 않음
    */
    let viewModel = BirthdatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
//        bind()
        bindMVVM()  // Rx + Input/Output + MVVM
        
        // 초기값의 유무
//        aboutPublishSubject()
//        aboutBehaviorSubject()
    }
    /*
    func bind() {
        /* 쓰레드 관점
        text  // Observable 데이터가 바뀌면  // Observer
            .bind(to: infoLabel.rx.text)  // Observer 여기에 보여달라
            .disposed(by: disposeBag)
        
        nextButton.rx.tap  // Observable
            .bind(with: self) { owner, _ in
                print("가입 가능")
                owner.text.onNext("가입 가능")  // 바로 실행되지는 않음, 클릭해야 이벤트가 전달됨
            }
            .disposed(by: disposeBag)
        
        // 네트워크 통신, 파일 다운로드처럼 백그라운드 쓰레드에서 동작할 수 있는 상황이 있다면
        nextButton.rx.tap
//            .observe(on: MainScheduler.instance)  // 안전하게 사용가능: 스트림을 바꿔줌
//            .subscribe(with: self) { owner, _ in
//            .bind(with: self) { owner, _ in  // 탭은 실패할일이 없으니까 bind 사용
                    // Binder 구조체는 메인쓰레드에서 동작하도록 구성되어 있음 (bind자체가 메인쓰레드로 바꿔주도록 만드는 기능은 없음)
            .asDriver()
            .drive(with: self) { owner, _ in  // UI업데이트
//                DispatchQueue.main.async {  // observe(on:)이 없다면 이렇게 처리해야함
                    owner.infoLabel.text = "입력했어요"  // UI 업데이트
//                }
            }
            .disposed(by: disposeBag)
        */
        /* 이벤트 관점
        text
//            .bind(to: yearLabel.rx.text)  // 텍스트 보내지는 일은 실패할리 없기 때문에 bind 사용
            .asDriver(onErrorJustReturn: "unknown")  // 만약 에러이벤트가 전달됐을 때 오류를 받지는 않지만, 최소한 앱이 터지지 않도록 예외처리를 안전하게 해줌
            .drive(yearLabel.rx.text)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.infoLabel.text = "입력했어요"
                owner.text.onError(JackError.invalid)  // next이벤트만 받으니까, 이벤트는 전달이 되는데 받지 못하고 앱이 터짐 (bind는 에러 받으면 안되는데.. 일단 받아버림 -> 처리 못하고 앱이 꺼짐: 실제 사용자 입장에서 버튼을 누르면 앱이 꺼짐)
            }
            .disposed(by: disposeBag)
         */
        // 스트림 관점
//        nextButton.rx
//            .tap
//            .map { "랜덤 \(Int.random(in: 1...100))" }  // 맵으로 타입을 Observable<String>으로 바꿈
//            .bind(to: yearLabel.rx.text, /*monthLabel.rx.text*/)  // 가변매개변수라 여러개 가능
//            .disposed(by: disposeBag)
//        
//        nextButton.rx.tap
//            .map { "랜덤 \(Int.random(in: 1...100))" }
//            .bind(to: monthLabel.rx.text)
//            .disposed(by: disposeBag)
//        
//        nextButton.rx.tap
//            .map { "랜덤 \(Int.random(in: 1...100))" }
//            .bind(to: dayLabel.rx.text)
//            .disposed(by: disposeBag)
        
        // 중복코드 없이 만드려고
        let tap = nextButton.rx.tap
            .map { "랜덤 \(Int.random(in: 1...100))" }
        // 상수에 담은걸 재활용했는데 랜덤 숫자가 모두 다르다 (위에처럼 개별 상수를 만드는 것과 같음)
        // 스트림이 공유되고 있지 않다: 버튼이 3번 클릭되는 현상
        // 네트워크 통신 코드였다면 네트워크 콜을 3번 쓰는 상황
//            .share()
            // 스트림이 나눠질거 같은 상황을 하나로
            // 스트림이 공유되는 상황
            // 버튼이 한번 클릭 재사용
            // 통신도 한번만
        // 코드적으로 상수로 묶는다고 묶여지는게 아님
            .asDriver(onErrorJustReturn: "")
        
        tap
//            .bind(to: yearLabel.rx.text, /*monthLabel.rx.text*/)  // 가변매개변수라 여러개 가능
            .drive(yearLabel.rx.text)
            .disposed(by: disposeBag)
        
        tap
//            .bind(to: monthLabel.rx.text)
            .drive(monthLabel.rx.text)
            .disposed(by: disposeBag)
        
        tap
//            .bind(to: dayLabel.rx.text)
            .drive(dayLabel.rx.text)
            .disposed(by: disposeBag)
        
        // Observable -> Stream을 공유하지 않고 -> bind
        // Subject -> Stream을 공유합니다
        text
            .bind(with: self) { owner, value in
                print("next 1", value)
            }
            .disposed(by: disposeBag)
        
        text
            .bind(with: self) { owner, value in
                print("next 2", value)
            }
            .disposed(by: disposeBag)
        
        text
            .bind(with: self) { owner, value in
                print("next 3", value)
            }
            .disposed(by: disposeBag)
        
        text.onNext("랜덤 \(Int.random(in: 1...100))")
        /**
         # Subject사용해서, bind여도 공유
         next 1 랜덤 87
         next 2 랜덤 87
         next 3 랜덤 87
         */
    }
    */
    
    func bindMVVM() {
        // input: date picker 날짜, output: y, m, d
//        let input = BirthdatViewModel.Input(datePicker: birthDayPicker.rx.date/*날짜바뀔때마다 실행됨*/)
        let input = BirthdatViewModel.Input()
        let output = viewModel.transform(input: input)
        
        birthDayPicker.rx.date
            .subscribe(with: self) { owner, date in
//                owner.viewModel.input.datePicker
                owner.viewModel.date.onNext(date)
            }
            .disposed(by: disposeBag)
        
        output.year
            .observe(on: MainScheduler.instance)
            .bind(to: yearLabel.rx.text)  // 통신이 아니니까 에러 안생기니까 bind
            .disposed(by: disposeBag)
        
        output.month
            .asDriver(onErrorJustReturn: "00월")  // 이것조차 비즈니스로직 아닌가?
            .drive(monthLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.day
            .drive(dayLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func aboutPublishSubject() {
//        let a = Array<String>()
        let text = PublishSubject<String>()  // 구조체의 인스턴스(제네릭) 초기화, 안에 String 들어감
        
        text.onNext("칙촉")  // 구독 전 이벤트 받을 수 없음: 전달은 하고 있지만 받지는 못하는 상태
        text.onNext("칫솔")
        
        text  // Observable로서 전달
            .subscribe(with: self) { owner, value in  // Observer
                print("PublishSubject next", value)
            } onError: { owner, error in
                print("PublishSubject error", error)
            } onCompleted: { owner in
                print("PublishSubject completed")
            } onDisposed: { owner in
                print("PublishSubject disposed")
            }
            .disposed(by: disposeBag)
        
        text.onNext("치약")  // 구독 후 이벤트만 전달됨 (전부 받을 수 있음)
//        text.onCompleted()  // error, completed 만나면 리소스 정리(구독 끊음) -> 그 시점을 확인 disposed (Observable 사이의 Observer 연결이 끊긴거라 이벤트를 받을 수 없음)
        /**
         PublishSubject completed
         PublishSubject disposed
         */
        text.onError(JackError.invalid)
        /**
         PublishSubject error invalid
         PublishSubject disposed
         */
        text.onNext("음료수")
    }
    
    func aboutBehaviorSubject() {
        let text = BehaviorSubject(value: "고래밥")  // 내가 가지고 있는 값은 무조건 하나 가지고 있고, 가장 마지막 이벤트를 가지고 방출된다 (뷰에 보여주고 싶은 초기값이 있을 때 사용: 플레이스홀더 등)
        // 이벤트를 전달하지 않았다면 난 뭘갖고 있어야하지? 그래서 초기값을 가지고 있음
        
//        text.onNext("칙촉")  // 이벤트 보내기
//        text.onNext("칫솔")  // 구독 전 하나의 이벤트를 챙겨올 수 있는 게 Behavior 특성 (하나를 미리 가질 수 있다)
        
        text  // Observable로서 전달
            .subscribe(with: self) { owner, value in  // Observer
                print("next", value)
            } onError: { owner, error in
                print("error", error)
            } onCompleted: { owner in
                print("completed")
            } onDisposed: { owner in
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        text.onNext("치약")  // 구독 후에는 모든 이벤트가 잘 전달됨
        text.onCompleted()
        /**
         next 고래밥
         next 치약
         completed
         disposed
         이후 이벤트는 전달되지 않음
         */
        //MARK: 나머지 서브젝트도 이렇게 확인해보기
        text.onNext("음료수")
    }
    
    func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
 
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
   
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
