import RxSwift
import RxCocoa
import UIKit

//: [Previous](@previous)
/*:
 # Hot and Cold Observables
 
 Copied from [RxSwift Documentation](https://github.com/ReactiveX/RxSwift/blob/master/Documentation/HotAndColdObservables.md)
 
 When does an Observable begin emitting its sequence of items? It depends on the Observable. A “hot” Observable may begin emitting items as soon as it is created, and so any observer who later subscribes to that Observable may start observing the sequence somewhere in the middle. A “cold” Observable, on the other hand, waits until an observer subscribes to it before it begins to emit items, and so such an observer is guaranteed to see the whole sequence from the beginning
 
 ## Hot Observables
 * ... are sequences
 * Use resources ("produce heat") no matter if there is any observer subscribed.
 * Variables / properties / constants, tap coordinates, mouse coordinates, UI control values, current time
 * Usually contains ~ N elements
 * Sequence elements are produced no matter if there is any observer subscribed.
 * Sequence computation resources are usually shared between all of the subscribed observers.
 * Usually stateful
 
 ## Cold Observables
 * ... are sequences
 * Don't use resources (don't produce heat) until observer subscribes.
 * Async operations, HTTP Connections, TCP connections, streams
 * Usually contains ~ 1 element
 * Sequence elements are produced only if there is a subscribed observer.
 * Sequence computation resources are usually allocated per subscribed observer.
 * Usually stateless
 
 Given this definition, is our previous Observable a hot one or cold one? Yeah you are right Dora, it is a hot one. How did we know?
 
 since our 1st and 2nd observer did not see the same sequence of events, as our 2nd observer subscribed after a certain amount of time.
 
 Vámonos!
*/

//: ## Hot Examples
//: **PublishSubjects**: Subscribers will only receive sequence values after subscription
    let temperature = PublishSubject<Float>()
    temperature.onNext(1.0)
    temperature.onNext(1.1)

    temperature.subscribe(onNext: { (temperature) in
        print("Current temperature is: \(temperature)")
    })

    temperature.onNext(2.0)
    temperature.onNext(3.0)
    temperature.onNext(1.0)
    //    temperature.onCompleted()
    //    temperature.onNext(3.0)
    //    temperature.onNext(1.0)
    // Your attempts are futile


//: **Variable**: Subscribers will receive last(initial) sequence value upon subscription as well as suceeding sequence values. **DEPRECATED in RxSwift5** Use BehaviorSubject/BehaviorRelays instead
    enum ViewStates {
        case unloaded
        case loaded
        case willAppear
        case didAppear
        case willDisappear
        case didDisappear
    }

    let currentState = Variable<ViewStates>(.unloaded)
//: **BehaviorSubject**: Subscribers will receive last(initial) sequence value upon subscription as well as suceeding sequence values
    let currentState2 = BehaviorSubject<ViewStates>(value: .loaded)
    currentState2.subscribe(onNext: { (state) in
        print("Current state is: \(state)")
    })

    currentState2.onNext(.willAppear)

//: Notice how the current/last value was printed out upon subscription, vs PublishSubject where the last value before subscription was not printed out

//: **ControlProperty**: Trait for `Observable`/`ObservableType` that represents property of UI element
    let textField = UITextField(frame: .zero)
    textField.rx.text.subscribe(onNext: { (text) in
        print("Current text is: \(text ?? "nil")")
    })

    let button = UIButton(frame: .zero)
    button.rx.tap.subscribe(onNext: { (sender) in
        print("Did tap sender: \(sender)")
    })

//: Moving on to Cold Observables. Hope that it won't bother you
//: ## Cold Examples

var movie = "Rambo"
let nowShowing = Observable<String>.create { (observer) -> Disposable in
        observer.on(.next(movie))
        return Disposables.create()
    }
//    .do(onNext: { (_) in
//        print("Side effect")
//    })
//let nowShowing = Observable.just(movie)
//let nowShowing = Observable.deferred { () -> Observable<String> in
//    return Observable.just(movie)
//}

nowShowing.subscribe(onNext: { (value) in
    print("Observer A: \(value)")
})

//movie = "Titanic"
//nowShowing.subscribe(onNext: { (value) in
//    print("Observer B: \(value)")
//})
//
//nowShowing.subscribe(onNext: { (value) in
//    print("Observer C: \(value)")
//})


//: [Next](@next)
