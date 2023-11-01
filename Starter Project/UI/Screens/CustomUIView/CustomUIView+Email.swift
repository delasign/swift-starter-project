//
//  CustomUIView+Email.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 11/1/23.
//

import Foundation
import MessageUI

extension CustomUIView: MFMailComposeViewControllerDelegate {
    func sendEmail() {
        if MFMailComposeViewController.canSendMail(), let vc = self.window?.rootViewController {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setSubject("A Subject")
            mail.setMessageBody("<p>Your message!</p>", isHTML: true)
            vc.present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let _ = self else { return }
            controller.dismiss(animated: true)
        }
    }
}
