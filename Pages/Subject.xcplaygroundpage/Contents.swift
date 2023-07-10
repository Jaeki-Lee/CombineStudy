//: [Previous](@previous)

import Foundation
import Combine

/*
 Subject
 publish 의 일종으로 바깥 으로 method 를 방출시키기 위한 객체
 이벤트를 방출할수 있는 send(subscription:) 기능이 존재
 */

/*
 PassthoughSubject
 하위 Subscriber 들에게 값을 방출 시키는 객체
 */

//let passSubject = PassthroughSubject<String, Never>()
//
//passSubject
//  .sink(receiveValue: { print($0) })
//
//passSubject.send("Test1")
//passSubject.send("Test2")

/*
 CurrentValueSubject
 Single value 를 래핑하고 값이 변경될때마다 새로운 값을 publish 하는 Subject 형태
 */

//반드시 초기값을 셋팅 해주어야 함
let currentSubject = CurrentValueSubject<String, Never>("currentValueSubject")

currentSubject
  .sink(receiveValue: { print($0) })

currentSubject.value = "Test1" // subject.send("Test1") 와 동일
currentSubject.send("Test2")
  
