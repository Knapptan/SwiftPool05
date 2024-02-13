//
//  main.swift
//  quest10
//
//  Created by Knapptan on 02.02.2024.
//

import Foundation
import RxSwift


struct Pair {
    let id: Int
    let count: Int
}

func executeTasks(_ data:  Observable<Sample>,_ number: Int) async {
    let disposeBag = DisposeBag()
    var formattedResult = "listOf("
    print("Quest \(number):", formattedResult)
    let quest1Result = await quest(data)
    _ = quest1Result.subscribe(
        onNext: { (answer) in
            print("Pair(\(answer.id),\(answer.count))")
        },
        onError: { (error) in
            print("Quest \(number) error:", error)
        },
        onCompleted: {}
    ).disposed(by: disposeBag)
    print(")")
}

// Задание 10: Группировка значений по id в secondCollection подсчет количества элементов в каждой группе.
// Пример вывода listOf(Pair(1, 2), Pair(2, 2), Pair(3, 1)
func quest(_ data: Observable<Sample>) async -> Observable<Pair> {
    return data
        .groupBy { $0.id }
        .flatMap { group -> Observable<Pair> in
            return group
                .toArray()
                .map { Pair(id: group.key, count: $0.count) }
                .asObservable()
        }
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
