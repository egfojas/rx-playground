import RxSwift

//: [Previous](@previous)
/*:
 # Observables and Observers
 
 ## Observables
 
 Observable is a sequence of **Events** that can be subscribed on by `observer`.
 * conforming to ObservableType protocol
 * sequences can produce zero or more elements so zero or more `Next` events can be sent to `observer`
 * once an `Error` or `Completed` event is sent, the sequence terminates and can't produce any other elements
 
 ### Events
 * Next - event that indicates that a new element has been produced in the sequence
 * Error - event that indicates that the sequence terminated with an error
 * Completed - event that indicates that the sequence terminated without any error
*/
//: Task: Create an Observable that emits an Integer value every second
// Here we are using PublishSubject which is a type that conforms to ObservableType protocol
let countStream = PublishSubject<Int>()

var count: Int = 0

//Dispatching to background queue to unblock main execution queue
func startEmitting() {
    DispatchQueue.global(qos: .background).async {
        while true {
            // Sending Next event to the sequence with `count` as the element
            countStream.onNext(count)
            sleep(1)
            count = count + 1
        }
    }
}

startEmitting()

/*:
 ## Observers
 
 Observer can subscribe to an Observable and listen to events
 * conforming to ObserverType protocol
*/
//: Task: Subscribe to the previous Observable and print the emitted elements
let _ = countStream.subscribe { (event) in
    switch event {
    case .next(let element):
        print("Receiver A: \(element)")
    case .error(let error):
        break
    case .completed:
        break
    }
}

//: Task: Create another `observer` and subscribe to the same Observable above after some x sec delay. Notice the starting value your new receiver gets.

sleep(5)
// Using a diffrent subscribe syntax
let disposable = countStream.subscribe(onNext: { (element) in
    print("Received B: \(element)")
}, onError: { (error) in
    //TODO
}, onCompleted: {
    //TODO
}, onDisposed: {
    //TODO
})

/*:
 Noticed the onDisposed parameter on the 2nd subscribe? While it is not really a case of Events enum, you can think of it in the same way. Each subscribe call to an Observable returns a Disposable object. Disposable is the subscription object that can be used to unsubscribe from the Observable sequence.
 * onDisposed: Action to invoke upon any type of termination of sequence (if the sequence has gracefully completed, errored, or if the generation is canceled by disposing subscription).
 
 
 ## BUT WAIT! Where is the Observer?
 In our definition of Observer, it is an object that conforms to ObserverType protocol. But we didn't really created anything that conforms to the ObserverType. At least not explicitly. The previous two subscription implementation saves us the trouble of defining our own Observer. If we explore the implementations of these, we can see that it allocates and use an instance of AnonymousObserver type inside the function bodies. (see ObservableType+Extenions.swift). You can still create and customize your own observer objects as long as it conforms to the ObserverType protocol.
 
*/



//: [Next](@next)
