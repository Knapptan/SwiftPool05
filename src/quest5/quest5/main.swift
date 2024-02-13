//
//  main.swift
//  quest5
//
//  Created by Knapptan on 02.02.2024.
//

import Foundation
import RxSwift

// Функция получения вывода от RxSwift
func executeTasks(_ data: Observable<String>,_ number: Int) async {
    let disposeBag = DisposeBag()
    let quest1Result = await quest(data)
    _ = quest1Result.subscribe(
        onNext: { (answer) in
            print("Quest \(number):", answer)
        },
        onError: { (error) in
            print("Quest \(number) error:", error)
        },
        onCompleted: {}
    ).disposed(by: disposeBag)
}

// Задание 5: Приоверка на отсутствие пустых строк в firstCollection
func quest(_ data: Observable<String>) async -> Observable<Bool> {
    return data
        .map { !$0.isEmpty }
        .reduce(true) { acc, value in acc && value }
}

// Функция main для выполнения заданий
func main() {
    let semaphore = DispatchSemaphore(value: 0)
    
    Task {
        await executeTasks(firstCollection, 5)
        semaphore.signal()
    }
    semaphore.wait()
}

// Вызов функции main
main()
