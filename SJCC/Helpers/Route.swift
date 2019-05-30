//
//  Route.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 24/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation

let Base_Url = "http://sjcc.edu.in/"

enum Route {
    case homeGallery
    case galleryImageList
    case news
    case notifications
    case parentsAnnouncements
    case programActivity
    case collegeRules
    case teacherMeetings
    case outreachProgramList
    case aluminiOfficeBearers
    case aluminiAssociationActivities
    case newsLetter
    case prospectUs
    case announcements
    case management
    case governingBody
    case governingIndividual
    case staffLogin
    case staffAchievementList
    case staffAnnouncementList
    case staffDuties
    case staffRules
    case staffSeminar
    case staffAcademicCalendar
    case studentLogin
    case studentAnnouncements
    case studentExaminations
    case studentActivities
    case studentActivityImages
    case studentPlacementCell
    case studentDownloads
    case studentSjccWrites
    
    var absoluteURL: URL {
        return URL(string: Base_Url + apiPath)!
    }
    
    private var apiPath: String {
        switch self {
        case .homeGallery:
            return "/sjcc_app/sjcc_photos.php"
        case .galleryImageList:
            return "/sjcc_app/sjcc_photo1.php"
        case .news:
            return "/sjcc_app/sjcc_news.php"
        case .notifications:
            return "/sjcc_app/sjcc_notification.php"
        case .parentsAnnouncements:
            return "/sjcc_app/sjcc_parentannouncement.php"
        case .programActivity:
            return "/sjcc_app/sjcc_program.php"
        case .collegeRules:
            return "/sjcc_app/sjcc_clgrules.php"
        case .teacherMeetings:
            return "/sjcc_app/sjcc_ptm.php"
        case .outreachProgramList:
            return "/sjcc_app/sjcc_outreach.php"
        case .aluminiOfficeBearers:
            return "/sjcc_app/sjcc_office.php"
        case .aluminiAssociationActivities:
            return "/sjcc_app/sjcc_alumni.php"
        case .newsLetter:
            return "/sjcc_app/sjcc_newsletter.php"
        case .prospectUs:
            return "/sjcc_app/prospectus.php"
        case .announcements:
            return "/sjcc_app/sjcc_announcement.php"
        case .management:
            return "/sjcc_app/sjcc_management.php"
        case .governingBody:
            return "/sjcc_app/sjcc_governing.php"
        case .governingIndividual:
            return "/sjcc_app/sjcc_governing1.php"
        case .staffLogin:
            return "/sjcc_app/sjcc_stafflogin.php"
        case .staffAchievementList:
            return "/sjcc_app/sjcc_staff.php"
        case .staffAnnouncementList:
            return "/sjcc_app/sjcc_remainder.php"
        case .staffDuties:
            return "/sjcc_app/sjcc_staffduties.php"
        case .staffRules:
            return "/sjcc_app/sjcc_rules.php"
        case .staffSeminar:
            return "/sjcc_app/sjcc_seminar.php"
        case .staffAcademicCalendar:
            return "/sjcc_app/sjcc_calendar.php"
        case .studentLogin:
            return "/sjcc_app/sjcc_stdlogin.php"
        case .studentAnnouncements:
            return "/sjcc_app/sjcc_stdannouncement.php"
        case .studentExaminations:
            return "/sjcc_app/sjcc_stdexam.php"
        case .studentActivities:
            return "/sjcc_app/sjcc_stdactivities.php"
        case .studentActivityImages:
            return "/sjcc_app/sjcc_stdactivities.php"
        case .studentPlacementCell:
            return "/sjcc_app/sjcc_placement.php"
        case .studentDownloads:
            return "/sjcc_app/sjcc_downloads.php"
        case .studentSjccWrites:
            return "/sjcc_app/sjcc_writes.php"
        }
    }
}
