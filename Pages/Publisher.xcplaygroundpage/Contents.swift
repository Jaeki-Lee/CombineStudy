import Foundation
import Combine

/*
 Publisher 사용 방법
 */

//1.sink로 구독해서 바로 사용하는 방법
//let publisher = [1,2,3].publisher
//
//publisher
//  .sink { print("출력? \($0)") }

//2.SwiftUI 에서는 Publisher, Subscriber 를 미리 정의하여 처리하는 형태

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
//
//let publisher = [1,2,3].publisher
//let subscriber = MySubscriber()
//publisher.subscribe(subscriber)

/*
 Publish 연산자
 */
//Just - 에러 타입은 항상 Never인 가장 단순한 형태의 Publisher
Just(1)
  .sink { print("Just: \($0)") }

Just((1,2,3))
  .sink { print("Just: \($0)") }

Just([1,2,3])
  .sink { print("Just: \($0)") }

//Sequence - 주어진 Sequence를 방출하는 Publisher
Publishers.Sequence<[Int], Never>(sequence: [1,2,3])
  .sink {
    print("receiveCompletion: \($0)")
  } receiveValue: {
    print("receiveValue: \($0)")
  }

//Future - Result 타입과 같이 성공 or 실패 두 가지 타입을 갖는 Publisher
//final class Future<Output, Failure> where Failure : Error
Future<Int, Never> { promise in
  promise(.success(5))
}
.sink { print($0) }

/*
 Future 를 사용하지 않는 코드
 struct ImageProcessorService {
   func run(
     _ image: UIImage,
     completion: (Result<UIImage, Error>) -> Void
   ) -> Void {
     print("some function")
   }
 }
 
 Future를 사용한 코드
 extension ImageProcessorService {
   func run(_ image: UIImage) -> Future<UIImage, Error> {
     Future { promise in
       self.run(image, completion: promise)
     }
   }
 }
*/

/*
 Fail 연산자 - fail을 바로 스트림으로 보내는 Publisher
 첫번째 인수는 에러를 방출할때 같이 방출할 값
 */

//["50", nil, "70"]
//  .publisher
//  .flatMap { value -> AnyPublisher<String, Error> in
//    guard let value = value else {
//      return Fail<String, Error>.eraseToAnyPublisher()
//    }
//    return Just(value).setFailureType(to: Error).eraseToAnyPublisher()
//  }
//  .sink {
//    print("receiveCompletion: \($0)")
//  } receiveValue: {
//    print("receiveValue: \($0)")
//  }

/*
 Empty - 값을 방출하지 않고 즉시 완료되는 Publisher
 */

Empty<String, Never>()
  .sink(
     receiveCompletion: { print("receiveCompletion: \($0)") },
     receiveValue: { print("receiveValue: \($0)") }
   )

/*
 Deferred- 구독이 일어나기 전까지 대기하고 있다가, 구독이 일어났을 때 Deferred 클로저 부분이 실행되는 Publisher
 */

Deferred { Just(1) }
  .sink(
    receiveCompletion: { print("receiveCompletion: \($0)") },
    receiveValue: { print("receiveValue: \($0)") }
  )
