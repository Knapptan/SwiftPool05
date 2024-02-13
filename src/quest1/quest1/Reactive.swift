import RxSwift

let firstCollection = Observable.of("first", "second", "third")

struct Sample {
    let id: Int
    let text: String
}

let secondCollection = Observable.of(
        Sample(id: 1, text: "some text"),
        Sample(id: 1, text: "any text"),
        Sample(id: 2, text: "more text"),
        Sample(id: 2, text: "other text"),
        Sample(id: 3, text: "too text")
)
