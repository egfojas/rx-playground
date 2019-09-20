import RxSwift

//: [Previous](@previous)

/*:
 # Disposable
 Disposable represents a disposable resource. Disposables define how the Observable resources are freed upon disposal.
 
 In RxSwift, a subscription to an Observable returns a Disposable. Subscriptions can/will be disposed upon:
 * Observable terminates with Completed/Error Event
 * Explicitly calling onDisposed() on the Disposable object
 * Deallocating of a DisposeBag that contains the Disposable object
 * Explicitly calling onDisposed() on the DisposeBag that contains the Disposable object
 
 ## DisposeBag
 DisposeBag is a class that can contain multiple Disposable objects, and automatically calls onDispose() on each, upon dispossal of the bag or upon deinit
 
 It is recommended to put all disposables inside a bag to make sure that all of our subscrption are properly disposed of.
 */

//: Code snippet from URLSession+Rx
//: Notice how the Disposable object was created with a closure that will cancel the created asyncronous task
public func response(request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
    return Observable.create { observer in
        let task = self.base.dataTask(with: request) { (data, response, error) in
//            observer.on(.next((httpResponse, data)))
//            observer.on(.completed)
        }
        
        task.resume()
        
        return Disposables.create(with: task.cancel)
    }
}

//: [Next](@next)
