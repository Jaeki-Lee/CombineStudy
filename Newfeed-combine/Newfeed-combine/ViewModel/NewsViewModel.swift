//
//  NewsViewModel.swift
//  Newfeed-combine
//
//  Created by JaeKi on 10/16/24.
//

import Combine
import SwiftUI

class NewsViewModel: ObservableObject {
  @Published var articles: [Article] = []
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
  var errorMessage: String = ""

  private var cancellables = Set<AnyCancellable>()
  private let networkManager = NetworkManager()

  func fetchNews(keyword: String = "keyword") {
    self.isLoading = true

    networkManager.fetchNews(keyword: keyword)
    /*
     Q.receive 에 main 스레드를 사용하는 이유가 뭔지? main 은 UI 그리는 스레드 인데 다른 스레드를 사용하는게 더 좋지 않을지?
     호출하는 부분이 UI 코드에서 호출하고 해당 데이터를 UI 에 업데이트 하니까 main 스레드에서 동작해야 하는게 맞음
     */
      .receive(on: DispatchQueue.main)
      .sink { completion in
        self.isLoading = false
        switch completion {
        case let .failure(error):
          self.isError = true
          self.errorMessage = "뉴스를 가져오는 중 오류가 발생했습니다: \(error)"
        case .finished:
          break
        }
      } receiveValue: { [weak self] response in
        self?.articles = response.articles
        self?.isError = false
      }
    /*
     Q.이렇게 cancellables 이 뭔지 어떻게 동작 되는건지?
     cancellables는 Combine의 AnyCancellable 인스턴스들을 저장하기 위한 Set입니다. 이를 통해 구독을 메모리에서 유지하고, 메모리 누수를 방지할 수 있습니다. store(in:)을 사용해 구독을 Set에 저장하고, 구독이 필요 없을 때 자동으로 해제되도록 관리합니다.
     */
      .store(in: &cancellables)
  }

}
