import UIKit

let queue = DispatchQueue(label: "command queue")
let group = DispatchGroup()

let startingWorkItem = DispatchWorkItem {
    print("Starting work")
}
queue.async(group: group, execute: startingWorkItem)

for i in 0..<10 {
    let workItem = DispatchWorkItem {
        print(i)
        if i == 5 {
            sleep(5)
        }
    }
    queue.async(group: group, execute: workItem)
}

/**
 The notify closure needs to happen after items
 have been added to group for it not to be
 called before the group is "actually finished"
 */
group.notify(queue: .main) {
    print("Group notified")
}
