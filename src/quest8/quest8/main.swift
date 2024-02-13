//
//  main.swift
//  quest8
//
//  Created by Knapptan on 02.02.2024.
//

import Foundation
import RxSwift

func executeTasks(_ data:  Observable<Sample>,_ number: Int) async {
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

// Задание 8: Подсчет количества строк в firstCollection
func quest(_ data: Observable<Sample>) async -> Observable<[String]> {
    return data
        .map {$0.text}
        .toArray()
        .asObservable()
}

// Функция main для выполнения заданий
func main() {
    let semaphore = DispatchSemaphore(value: 0)
    
    Task {
        await executeTasks(secondCollection, 8)
        semaphore.signal()
    }
    semaphore.wait()
}

// Вызов функции main
main()
