//
//  main.swift
//  quest2
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

// Задание 2: Получение первого элемента из firstCollection, начинающегося на "th"
func quest(_ data: Observable<String>) async -> Observable<String> {
    return data
        .filter { $0.hasPrefix("th") }
        .take(1)
}

// Функция main для выполнения заданий
func main() {
    let semaphore = DispatchSemaphore(value: 0)
    
    Task {
        await executeTasks(firstCollection, 2)
        semaphore.signal()
    }
    semaphore.wait()
}

// Вызов функции main
main()
