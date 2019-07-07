//
//  UIStoryboardExtension.swift
//  BREADS
//
//  Created by Dharani Reddy on 12/12/18.
//  Copyright © 2018 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum Storyboard : String {
    case main = "Main"
    // add enum case for each storyboard in your project
}

fileprivate extension UIStoryboard {
    
    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }
    
    // optionally add convenience methods for other storyboards here ...
    
    // ... or use the main loading method directly when
    // instantiating view controller from a specific storyboard
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}

// MARK: App View Controllers

extension UIStoryboard {
    class func loadNewsDetailViewController() -> NewsDetailedViewController {
        return loadFromMain(String(describing: NewsDetailedViewController.self)) as! NewsDetailedViewController
    }
    
    class func loadWebViewController() -> WebViewController {
        return loadFromMain(String(describing: WebViewController.self)) as! WebViewController
    }

    class func loadParentsViewController() -> ParentsViewController {
        return loadFromMain(String(describing: ParentsViewController.self)) as! ParentsViewController
    }
    
    class func loadParentsAnnouncementsViewController() -> ParentsAnnouncementsViewController {
        return loadFromMain(String(describing: ParentsAnnouncementsViewController.self)) as! ParentsAnnouncementsViewController
    }
    
    class func loadTeacherProgramsViewController() -> TeacherProgramsViewController {
        return loadFromMain(String(describing: TeacherProgramsViewController.self)) as! TeacherProgramsViewController
    }
    
    class func loadAluminiViewController() -> AluminiViewController {
        return loadFromMain(String(describing: AluminiViewController.self)) as! AluminiViewController
    }
    
    class func loadAluminiBearerActivitiesViewController() -> AluminiBearerActivitiesViewController {
        return loadFromMain(String(describing: AluminiBearerActivitiesViewController.self)) as! AluminiBearerActivitiesViewController
    }
    
    class func loadNewsLetterViewController() -> NewsLetterViewController {
        return loadFromMain(String(describing: NewsLetterViewController.self)) as! NewsLetterViewController
    }
    
    class func loadAdmissionsViewController() -> AdmissionsViewController {
        return loadFromMain(String(describing: AdmissionsViewController.self)) as! AdmissionsViewController
    }
    
    class func loadHomeGalleryViewController() -> HomeGalleryViewController {
        return loadFromMain(String(describing: HomeGalleryViewController.self)) as! HomeGalleryViewController
    }
    
    class func loadGalleryFullImageViewController() -> GalleryFullImageViewController {
        return loadFromMain(String(describing: GalleryFullImageViewController.self)) as! GalleryFullImageViewController
    }
    
    class func loadProspectUsViewController() -> ProspectUsViewController {
        return loadFromMain(String(describing: ProspectUsViewController.self)) as! ProspectUsViewController
    }
    
    class func loadAnnouncementsViewController() -> AnnouncementsViewController {
        return loadFromMain(String(describing: AnnouncementsViewController.self)) as! AnnouncementsViewController
    }
    
    class func loadManagementViewController() -> ManagementViewController {
        return loadFromMain(String(describing: ManagementViewController.self)) as! ManagementViewController
    }
    
    class func loadGoverningBodyViewController() -> GoverningBodyViewController {
        return loadFromMain(String(describing: GoverningBodyViewController.self)) as! GoverningBodyViewController
    }
    
    class func loadStaffViewController() -> StaffViewController {
        return loadFromMain(String(describing: StaffViewController.self)) as! StaffViewController
    }
    
    class func loadStaffRulesViewController() -> StaffRulesDutiesViewController {
        return loadFromMain(String(describing: StaffRulesDutiesViewController.self)) as! StaffRulesDutiesViewController
    }
    
    class func loadStaffSeminarsCalendarsViewController() -> StaffSeminarsCalendarsViewController {
        return loadFromMain(String(describing: StaffSeminarsCalendarsViewController.self)) as! StaffSeminarsCalendarsViewController
    }
    
    class func loadStaffRequestsViewConytoller() -> StaffRequestsViewController {
        return loadFromMain(String(describing: StaffRequestsViewController.self)) as! StaffRequestsViewController
    }
    
    class func loadStaffAcheivementsViewController() -> StaffAcheivementsViewController {
        return loadFromMain(String(describing: StaffAcheivementsViewController.self)) as! StaffAcheivementsViewController
    }
    
    class func loadStudentViewController() -> StudentViewController {
        return loadFromMain(String(describing: StudentViewController.self)) as! StudentViewController
    }
    
    class func loadStudentAnnouncementExaminationsViewController() -> StudentAnnouncementsExaminationsViewController {
        return loadFromMain(String(describing: StudentAnnouncementsExaminationsViewController.self)) as! StudentAnnouncementsExaminationsViewController
    }
    
    class func loadStudentActivitiesViewController() -> StudentActivitiesViewController {
        return loadFromMain(String(describing: StudentActivitiesViewController.self)) as! StudentActivitiesViewController
    }
    
    class func loadStudentPlacementsViewController() -> StudentPlacementCellViewController {
        return loadFromMain(String(describing: StudentPlacementCellViewController.self)) as! StudentPlacementCellViewController
    }
    
    class func loadStudentWelfareCommitteesViewController() -> StudentWelfareCommitteesViewController {
        return loadFromMain(String(describing: StudentWelfareCommitteesViewController.self)) as! StudentWelfareCommitteesViewController
    }
}
