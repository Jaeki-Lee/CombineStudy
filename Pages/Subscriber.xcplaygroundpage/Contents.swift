import Combine

//class MySubscriber: Subscriber {
//  //성공 타입
//  typealias Input = Int
//  //실패 타입
//  typealias Failure = Never
//
//  func receive(_ input: Int) -> Subscribers.Demand {
//    print("데이터 수신: \(input)")
//    return .none
//  }
//
//  func receive(subscription: Subscription) {
//    print("데이터 구독 시작")
//    subscription.request(.unlimited) //구독할 데이터 제한
//  }
//
//  func receive(completion: Subscribers.Completion<Never>) {
//    print("모든 데이터 발행 완료")
//  }
//}

//let myPublisher = [1,2,3].publisher
//let subscriber = MySubscriber()
//myPublisher
//  .subscribe(subscriber)

/*
 AnySubscriber: 타입이 제거된 subscriber (가장 추상적인 Subscriber 형태)
 세부 정보를 외부에 숨겨서, 결합도를 낮추는데 사용
 */

let subscriber = AnySubscriber<Int, Never> { sub in
  print("receiveSubscription: \(sub)")
} receiveValue: { v1 in
  print("receiveValue: \(v1)")
  return .max(1)
} receiveCompletion: { _ in
  print("receiveCompletion")
}

[1, 2]
  .publisher
  .subscribe(subscriber)
