//
//  NetworkManager.swift
//  Newfeed-combine
//
//  Created by JaeKi on 10/16/24.
//

import Combine
import Foundation

class NetworkManager {
  private let apiKey: String = "83a0badf38584facb18545a0c3644d60"
  private let baseURL: String = "https://newsapi.org/v2/"

  init () {}

  func fetchNews(keyword: String) -> AnyPublisher<NewsResponse, Error> {
    guard let url = URL(string: "\(baseURL)everything?q=\(keyword)&apiKey=\(apiKey)") else {
      return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }

    return URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: NewsResponse.self, decoder: JSONDecoder())
    // 특정 Publisher를 AnyPublisher로 타입을 숨겨 반환하는 메서드입니다. 이렇게 하면 외부에서 해당 Publisher의 구체적인 타입을 알 필요 없이 사용할 수 있어 모듈성을 높이고, 코드의 유연성을 증가시킬 수 있습니다.
      .eraseToAnyPublisher()
  }

  func headLineNews() -> AnyPublisher<NewsResponse, Error> {
    guard let url = URL(string: "\(baseURL)top-headlines?country=us&apiKey=\(apiKey)") else {
      return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }

    return URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: NewsResponse.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }


}
