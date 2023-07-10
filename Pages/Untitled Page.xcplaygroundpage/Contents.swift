//: [Previous](@previous)

import Combine
import Foundation

/*
 Scheduler - 언제 어떻게 클로저가 실행될지 정하는 프로토콜
 thtead, 시간설정
 
 thread 변경
 receive(on:): downstream의 스레드 변경
 subscribe(on:): upstream의 스레드 변경
 
 receive(on:), subscribe(on:) 안쓴 경우 스레드 확인
 DispatchQueue.global()로 실행한 경우, main thread가 아닌 global thread에서 sink의 클로저 부분이 동작
 즉, 따로 스케줄러 설정을 하지 않으면 subject의 이벤트를 발행하는 쪽의 스케줄러와 동일하기 sink 클로저 부분이 동작
 */

let subject = PassthroughSubject<Void, Never>()

//subject
//  .sink { _ in
//    print(Thread.isMainThread)
//  }
//
//subject.send(()) //true
//
//DispatchQueue.global().async {
//  subject.send(()) //false
//}

let cancellable = subject
  .handleEvents {_ in
    print("upstream: \(Thread.isMainThread)")
  } // false
  .receive(on: DispatchQueue.main)
  .handleEvents {_ in
    print("downstram: \(Thread.isMainThread)")
  } // true
  .sink { _ in
    print()
  }

//playground 라서 무조건 main thread
DispatchQueue.global().async {
  subject.send(())
}

Just(1)
  .map { _ in print(Thread.isMainThread) }
  .subscribe(on: DispatchQueue.global())
  .sink { print(Thread.isMainThread) }

let cancellable2 = Just(1)
  .receive(on: DispatchQueue.main)
  .map { _ in print(Thread.isMainThread) }
  .delay(for: 2, scheduler: DispatchQueue.global()) // background thread로 변경
  .sink { print(Thread.isMainThread) } // 여기도 background thread
