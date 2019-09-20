import RxSwift

//: [Previous](@previous)
/*:
 # Operators
 
 In RxSwift/Rx, there are a lot or Operators that can be utilised to manipulate Observables. I'll be listing some of the common operators that are useful in most scenarios
 
 You can checkout the ff resources for more info:
 * [Playground](https://github.com/ReactiveX/RxSwift/tree/master/Rx.playground) - Official RxSwift Playground
 * [RxMarbles](https://rxmarbles.com/) - visualizations
 * [CheatSheet](https://www.cheatography.com/donghua-li/cheat-sheets/rxswift-operators/)
 * [Rx Operators](http://reactivex.io/documentation/operators.html)
 */

//: Creation Operators
    let singleObservable = Observable.just(1)
    let arrayObservable = Observable.from([1, 2, 3, 4])
    let terminateWithoutEmit = Observable<String>.empty()
    let terminateWithError = Observable<Error>.error(NSError(domain: "", code: 0, userInfo: nil))
    let createObservableForEachSubscription = Observable.deferred { () -> Observable<Int> in
        return Observable.just(1)
    }
    

//: Combination Operators
//: Try examples below and try to determine how each combine operators behaves
    var signalA = PublishSubject<String>()
    var signalB = PublishSubject<String>()

    Observable.combineLatest(signalA, signalB).subscribe(onNext: { (values) in
        print("Combined Latest: " + values.0, values.1)
    })

    Observable.merge(signalA, signalB).subscribe(onNext: { (value) in
        print("Merged: " + value)
    })

    Observable.zip(signalA, signalB) .subscribe(onNext: { (value) in
        print("Zipped: " + value.0, value.1)
    })


    signalB.withLatestFrom(signalA) { (valueA, valueB) -> String in
        return valueA + valueB
    }.subscribe(onNext: { (value) in
        print("WithLatestFrom: " + value)
    })

//    signalB.onNext("B")
    signalA.onNext("A")
    signalB.onNext("B")
//    signalB.onNext("C")
//    signalA.onNext("D")
//    signalA.onCompleted()
//    signalB.onCompleted()


//: Transforming Operators

    let boolStream = PublishSubject<Bool>()
    let negator = boolStream.map { (bool) -> Bool in
        return !bool
    }

    negator.subscribe(onNext: { (negated) in
        print(negated)
    })

    boolStream.onNext(true)
    boolStream.onNext(true)
    boolStream.onNext(false)

    let serialChefsOrders = PublishSubject<(meat: String, sauce: String)>()
    func prepareOrder(_ order: (meat: String, sauce: String)) -> Observable<String> {
        func fryMeat(_ meat: String) -> Observable<String> {
            print("Frying \(meat)...")
            return Observable.just("Fried " + meat).delay(2.0, scheduler: MainScheduler())
        }
        
        func prepareSauce(_ sauce: String) -> Observable<String> {
            print("Preparing \(sauce)...")
            return Observable.just("Amazing " + sauce).delay(1.0, scheduler: MainScheduler())
        }

        return fryMeat(order.meat).flatMap({ (preparedMeat) -> Observable<String> in
            return prepareSauce(order.sauce).map({ (preparedSauce) -> String in
                return preparedMeat + " with " + preparedSauce
            })
        })
    }

    serialChefsOrders.subscribe(onNext: { (order) in
        prepareOrder(order).subscribe(onNext: { (meal) in
            print("TADAH: " + meal)
        })
    })

//    serialChefOrders.flatMap { (order) -> Observable<String> in
//        return prepareOrder(order)
//    }.subscribe(onNext: { (meal) in
//        print("TADAH: " + meal)
//    })

//    serialChefsOrders.onNext((meat: "Chicken", sauce: "Chili"))

//: Filtering/Conditional Operators
    let intStream = Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

    intStream.filter { (value) -> Bool in
        return value > 5
    }.subscribe(onNext: { (value) in
        print(value)
    })

    intStream.takeWhile { (value) -> Bool in
        return value < 5
    }.subscribe(onNext: { (value) in
        print(value)
    })

    let boolStream2 = Observable.from([1, 1, 2, 3, 3, 3, 4, 5, 1, 1])
    boolStream2.distinctUntilChanged().subscribe(onNext: { (value) in
        print(value)
    })

//: [Next](@next)
