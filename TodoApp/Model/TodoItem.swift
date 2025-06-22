//
//  TodoItem.swift
//  TodoApp
//
//  Created by niino yuto on 2025/06/19.
//
import Foundation

struct TodoItem: Identifiable, Codable {
    let id: UUID = UUID() // 自動で一意のIDを生成
    var title: String     // ToDoのタイトル
    var isDone: Bool      // 完了してるかどうか
}
