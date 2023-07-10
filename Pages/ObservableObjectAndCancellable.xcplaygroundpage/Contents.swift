import UIKit
import Combine



/*
Published
*/

//final class MyData {
//  @Published
//  var number: Int
//
//  init(number: Int) {
//    self.number = number
//  }
//}
//
//let data = MyData(number: 20)
//
//data.$number
//  .sink { print("Change value? = \($0)") }
//
//data.number = 10
//
//data.number = 1


/*
 ObservableObject 이해 안됨
 20
 change value? = ()
 10
 change value? = ()
*/

//final class MyData: ObservableObject {
//  var number: Int {
//    willSet {
//      print(number)
//      self.objectWillChange.send()
//
//    }
//  }
//
//  init(number: Int) {
//    self.number = number
//  }
//}
//
//var data = MyData(number: 20)
//data.objectWillChange
//  .sink { print("change value? = \($0)") }
//
//data.number = 10
//data.number = 1

/*
 Cancel
 */

final class MyModel {
  @Published
  var number: Int

  init(number: Int) {
    self.number = number
  }
}
//
//let model = MyModel(number: 20)
//let anyCancellable = model.$number
//  .sink { print($0) }
//
//model.number = 10
//model.number = 1
//
//anyCancellable.cancel()
//model.number = 2
//model.number = 3

/*
 RxSwift 의 DisposeBag 처럼 사용
 */

//var cancellables = Set<AnyCancellable>()
//let model = MyModel(number: 20)
//let anyCancellable: () = model.$number
//  .sink { print($0) }
//  .store(in: &cancellables)
//
//model.number = 10
//model.number = 1
//model.number = 3
//
//cancellables = Set<AnyCancellable>()
//
//model.number = 5
//model.number = 3

