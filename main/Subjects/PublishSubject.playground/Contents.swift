//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift


/*:
 # PublishSubject
 */

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}
// PublishSubject
// Subject로 전달되는 이벤트를 observer에게 전달하는 가장 기본적인 형태의 Subject

// Observable인 동시에 Observer이다.
// 이벤트를 전달받을 수 있고, 다른 옵저버로 이벤트를 전달할 수 있다.
let subject = PublishSubject<String>()
subject.onNext("Hello")

// 구독자가 구독하기 전 전달되었던 NextEvent("Hello")는 o1 Observer로 전달되지 않는다.
let o1 = subject.subscribe { print(">> 1", $0)}
o1.disposed(by: disposeBag)

subject.onNext("RxSwift")

let o2 = subject.subscribe { print(">> 2", $0)}
o2.disposed(by: disposeBag)

subject.onNext("Subject")

// Completed, Error Event가 전달된 이후에 Next 이벤트는 전달되지 않는다.
// observable의 lifecycle 종료

//subject.onCompleted()
subject.onError(MyError.error)

let o3 = subject.subscribe { print(">> 3", $0)}
o3.disposed(by: disposeBag)

// PublishSubject는 이벤트가 전달되면. 즉시 구독자에게 전달한다.
// 따라서 Subject가 최초로 생성되는 시점과 첫번째 구독이 시작되는 시점 사이에 전달되는 이벤트는 사라진다.
// 이벤트가 사라지는게 문제라면 replaySubject 나 HoldObservable을 사용한다.
