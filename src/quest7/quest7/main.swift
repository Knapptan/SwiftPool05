//
//  main.swift
//  quest7
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

// Задание 7: Подсчет количества строк в firstCollection
func quest(_ data: Observable<String>) async -> Observable<Int> {
    return data
        .map {_ in 1}
        .reduce(0, accumulator: +)
}

// Функция main для выполнения заданий
func main() {
    let semaphore = DispatchSemaphore(value: 0)
    
    Task {
        await executeTasks(firstCollection, 7)
        semaphore.signal()
    }
    semaphore.wait()
}

// Вызов функции main
main()
