//
//  AirDropOnlySource.swift
//  AirdropFeature
//
//  Created by Sahin Raj on 5/4/20.
//  Copyright © 2020 Sahin Raj. All rights reserved.
//

import UIKit


class AirDropOnlySource: NSObject, UIActivityItemSource {
    ///The item you want to send via AirDrop.
    let item: Any

    init(item: Any) {
        self.item = item
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
         return NSURL(string: "")!
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return item
    }
}
