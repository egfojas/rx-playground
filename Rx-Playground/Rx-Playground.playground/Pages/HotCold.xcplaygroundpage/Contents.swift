import RxSwift
import RxCocoa
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


//: **Variable**: Subscribers will receive last(initial) sequence value upon subscription as well as suceeding sequence values. **DEPRECATED in RxSwift5**
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
        print("Current state is: \(temperature)")
    })

    currentState2.onNext(.willAppear)

//: **ControlProperty**: Trait for `Observable`/`ObservableType` that represents property of UI element
    let textField = UITextField(frame: .zero)
    let textStream = textField.rx.text

    let button = UIButton(frame: .zero)
    button.rx.tap

//: ## Cold Examples
 
 
 */

//publisher.onNext(5)
//publisher.onNext(6)
//
//let coldObservable = Observable.deferred({ () -> Observable<Date> in
//    return Observable.just(Date())
//})
//
//coldObservable.subscribe(onNext: { (value) in
//    print("radio3: \(value)")
//})
//
//sleep(3)
//
//coldObservable.subscribe(onNext: { (value) in
//    print("radio3: \(value)")
//})

//: [Next](@next)
