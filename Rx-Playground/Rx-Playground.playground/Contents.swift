import UIKit
import RxSwift

var str = "Hello, playground"
let publisher = PublishSubject<Float>()

publisher.subscribe(onNext: { (value) in
    print("radio1: \(value)")
})

publisher.onNext(1)
publisher.onNext(2)
publisher.onNext(3)
publisher.onNext(4)

publisher.subscribe(onNext: { (value) in
    print("radio2: \(value)")
})

publisher.onNext(5)
publisher.onNext(6)

let coldObservable = Observable.deferred({ () -> Observable<Date> in
    return Observable.just(Date())
})

coldObservable.subscribe(onNext: { (value) in
    print("radio3: \(value)")
})

sleep(3)

coldObservable.subscribe(onNext: { (value) in
    print("radio3: \(value)")
})

