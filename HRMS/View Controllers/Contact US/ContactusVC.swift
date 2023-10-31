//
//  ContactusVC.swift
//  
//
//  Created by Ahmed on 17/01/2022.
//

import UIKit

class ContactusVC: UIViewController ,UITextViewDelegate{
    @IBOutlet weak var contactTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // contactTextView.delegate = self
    
self.contactTextView.text = "Dubai Office\nBuilding Number 3\nApartment Number 30-01-2098\n3rd Floor, DMCC,  Dubai, U.A.E.\nPhone: +971 50 897 6875\n\nKarachi Office\n59-C, 3rd floor, Shehbaz Commercial (Small)\nDHA Phase 6, Saba Avenue\nKarachi - Pakistan.\nPhone: 021 35247132\n\nLahore Office\nExD House\n89-I, Jail Road\nLahore - Pakistan.\nPhone: +92 (42) 3540 8548-52\nToll Free: 0800 11393\nFax:+92 (42) 3540 8547\n\nMuzaffarabad Office\nNear City Post, Muzaffarabad\n\nAzad Jammu and Kashmir - Pakistan.\n\nExD - Rke Technology - Riyadh\nRiyadh 11695, PO Box 103083\nRiyadh, Saudi Arabia\nPhone: +966 (1) 4744844\nFax: +966 (1) 4734333\n\nRawalpindi Office\nApartment no 9, 8th floor, Al Ahad Heights,\nRabia Banglow, Defence Chowk, Jehlum Road,\nRawalpindi - Pakistan.\nPhone: 051-5400154\n\nE-mail: info@exdow.com"

        
    }
    

}
