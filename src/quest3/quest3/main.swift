//
//  main.swift
//  quest3
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

// Задание 3: Приоверка что все элементы из firstCollection длиной 5 символов и больше
func quest(_ data: Observable<String>) async -> Observable<Bool>{
    return data
        .map { $0.count >= 5 }
        .reduce(true) { acc, value in acc && value }
    }

// Функция main для выполнения заданий
func main() {
    let semaphore = DispatchSemaphore(value: 0)
    
    Task {
        await executeTasks(firstCollection, 3)
        semaphore.signal()
    }
    semaphore.wait()
}

// Вызов функции main
main()
