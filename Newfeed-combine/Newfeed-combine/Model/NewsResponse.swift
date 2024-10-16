//
//  NewsResponse.swift
//  Newfeed-combine
//
//  Created by JaeKi on 10/16/24.
//

import Foundation

struct NewsResponse: Decodable {
  let status: String
  let totalResults: Int
  let articles: [Article]
}

struct Article: Decodable, Identifiable {
  let id = UUID()
  let source: Source
  let author: String?
  let title: String
  let description: String?
  let url: String
  let urlToImage: String?
  let publishedAt: String
  let content: String?
}

struct Source: Decodable {
  let id: String?
  let name: String
}
