//
//  AdMobViews.swift
//  Connectify
//
//  Created by James on 8/22/24.
//

import Foundation
import SwiftUI
import GoogleMobileAds


struct BannerView: UIViewControllerRepresentable {
	
	@State private var viewWidth: CGFloat = .zero
	
	private var adUnitID: String = ""
	private let bannerView = GADBannerView()	
	
	init(adUnitID: String) {
		self.adUnitID = adUnitID
	}
	
	
	func makeUIViewController(context: Context) -> some UIViewController {
		let bannerViewController = BannerViewController()
		
		bannerView.adUnitID = self.adUnitID
		bannerView.rootViewController = bannerViewController
		bannerView.delegate = context.coordinator
		bannerView.translatesAutoresizingMaskIntoConstraints = false
		bannerViewController.view.addSubview(bannerView)
		
		// Constrain GADBannerView to the bottom of the view.
		NSLayoutConstraint.activate([
			bannerView.bottomAnchor.constraint(
				equalTo: bannerViewController.view.safeAreaLayoutGuide.bottomAnchor),
			bannerView.centerXAnchor.constraint(equalTo: bannerViewController.view.centerXAnchor),
		])
		bannerViewController.delegate = context.coordinator
		
		return bannerViewController
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		guard viewWidth != .zero else {
			return
		}
		
		// Request a banner ad with the updated viewWidth.
		bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
		bannerView.load(GADRequest())
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	internal class Coordinator: NSObject, BannerViewControllerWidthDelegate, GADBannerViewDelegate {
		let parent: BannerView
		
		init(_ parent: BannerView) {
			self.parent = parent
		}
		
		// MARK: - BannerViewControllerWidthDelegate methods
		
		func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat) {
			parent.viewWidth = width
		}
		
		// MARK: - GADBannerViewDelegate methods

		func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
		  print("\(#function) called")
		}

		func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
		  print("\(#function) called")
		}

		func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
		  print("\(#function) called")
		}

		func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
		  print("\(#function) called")
		}

		func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
		  print("\(#function) called")
		}

		func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
		  print("\(#function) called")
		}
	}
}

protocol BannerViewControllerWidthDelegate: AnyObject {
	func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat)
}

class BannerViewController: UIViewController {
	weak var delegate: BannerViewControllerWidthDelegate?

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		// Tell the delegate the initial ad width.
		delegate?.bannerViewController(self, didUpdate: view.frame.inset(by: view.safeAreaInsets).size.width)
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		coordinator.animate { _ in
			// do nothing
		} completion: { _ in
			// Notify the delegate of ad width changes.
			self.delegate?.bannerViewController(self, didUpdate: self.view.frame.inset(by: self.view.safeAreaInsets).size.width)
		}
	}
}
