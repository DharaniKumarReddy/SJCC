//
//  Parser.swift
//  SJCC
//
//  Created by Dharani Reddy on 07/04/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation

struct GalleryArray: Codable {
    var sjccPhotos: [HomeGallery]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case sjccPhotos = "sjcc_photos", success = "success", message = "message"
    }
}

struct HomeGallery: Codable {
    var id: String
    var title: String
    var image: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", image = "image", updatedAt = "updated_at"
    }
}

struct News: Codable {
    var id: String
    var title: String
    var image: String
    var updatedAt: String
    var date: String
    var description: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", image = "image", updatedAt = "updated_at", date = "date", description = "description"
    }
}

struct NewsArray: Codable {
    var news: [News]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case news = "sjcc_news", success = "success", message = "message"
    }
}

struct Notifications: Codable {
    var success: Int
    var message: String
    var sjccNotifications: [Notification]
    
    private enum CodingKeys: String, CodingKey {
        case success = "success", message = "message", sjccNotifications = "sjcc_notification"
    }
}

struct Notification: Codable {
    var id: String
    var title: String
    var date: String
    var topicName: String
    var description: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", date = "date", topicName = "topicname", description = "description", updatedAt = "updated_at"
    }
}

struct ParentsAnnouncement: Codable {
    var id: String
    var title: String
    var date: String
    var pdf: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", date = "date", pdf = "pdf", updatedAt = "updated_at"
    }
}

struct ParentsAnnouncements: Codable {
    var announcements: [ParentsAnnouncement]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case announcements = "parent_announcement", message = "message", success = "success"
    }
}

struct BasicModel: Codable {
    var id: String
    var title: String
    var description: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", description = "description", updatedAt = "updated_at"
    }
}

struct ProgramActivity: Codable {
    var programActivity: [BasicModel]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case programActivity = "sjcc_program", message = "message", success = "success"
    }
}

struct CollegeRules: Codable {
    var rules: [BasicModel]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case rules = "sjcc_collegerules", message = "message", success = "success"
    }
}

struct TeacherMeeting: Codable {
    var id: String
    var title: String
    var date: String
    var description: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", date = "date", description = "description", updatedAt = "updated_at"
    }
}

struct TeacherMeetings: Codable {
    var meetings: [TeacherMeeting]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case meetings = "sjcc_meeting", success = "success", message = "message"
    }
}

struct OutReachPrograms: Codable {
    var programs: [News]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case programs = "sjcc_outreach", success = "success", message = "message"
    }
}

struct OfficeBearer: Codable {
    var id: String
    var name: String
    var designation: String
    var image: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", designation = "designation", image = "image", updatedAt = "updated_at"
    }
}

struct OfficeBearers: Codable {
    var bearers: [OfficeBearer]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case bearers = "office_bearers", message = "message", success = "success"
    }
}

struct AluminiActivities: Codable {
    var activities: [TeacherMeeting]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case activities = "alumni_activities", success = "success", message = "message"
    }
}

struct NewsLetter: Codable {
    var id: String
    var image: String
    var title: String
    var date: String
    var pdf: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", image = "image", title = "title", date = "date", pdf = "pdf", updatedAt = "updated_at"
    }
}

struct NewsLetters: Codable {
    var letters: [NewsLetter]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case letters = "sjcc_newsletter", success = "success", message = "message"
    }
}

struct GalleryFullImage: Codable {
    var id: String
    var pId: String
    var image: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", pId = "p_id", image = "images", updatedAt = "updated_at"
    }
}

struct GalleryFullImageList: Codable {
    var images: [GalleryFullImage]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case images = "photoimages", success = "success", message = "message"
    }
}

struct ProspectUs: Codable {
    var prospectList: [NewsLetter]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case prospectList = "sjcc_prospectus", success = "success", message = "message"
    }
}

struct Announcements: Codable {
    var announcements: [ParentsAnnouncement]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case announcements = "sjcc_announcement", message = "message", success = "success"
    }
}

struct Management: Codable {
    var id: String
    var name: String
    var designation: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", designation = "designation", updatedAt = "updated_at"
    }
}

struct ManagementList: Codable {
    var list: [Management]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case list = "sjcc_management", message = "message", success = "success"
    }
}

struct GoverningBody: Codable {
    var id: String
    var title: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", updatedAt = "updated_at"
    }
}

struct GoverningBodies: Codable {
    var bodies: [GoverningBody]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case bodies = "sjcc_governing", message = "message", success = "success"
    }
}

struct StaffLogin: Codable {
    var id: String
    var email: String
    var password: String
}

struct StaffLoginData: Codable {
    var staff: [StaffLogin]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case staff = "staff_login", message = "message", success = "success"
    }
}

struct StaffRules: Codable {
    var rules: [TeacherMeeting]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case rules = "sjcc_rules", success = "success", message = "message"
    }
}

struct StaffDuties: Codable {
    var duties: [NewsLetter]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case duties = "sjcc_staffduties", success = "success", message = "message"
    }
}

struct StaffSeminars: Codable {
    var seminars: [NewsLetter]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case seminars = "sjcc_seminar", success = "success", message = "message"
    }
}

struct StaffCalendar: Codable {
    var id: String
    var title: String
    var date: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", date = "date", updatedAt = "updated_at"
    }
}

struct StaffCalendars: Codable {
    var calendars: [StaffCalendar]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case calendars = "sjcc_calendar", message = "message", success = "success"
    }
}

struct StaffRemainderAnnouncements: Codable {
    var remainders: [ParentsAnnouncement]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case remainders = "sjcc_remainder", message = "message", success = "success"
    }
}

struct StaffAcheivement: Codable {
    var id: String
    var name: String
    var image: String
    var date: String
    var designation: String
    var description: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", image = "image", date = "date", designation = "designation", description = "description", updatedAt = "updated_at"
    }
}

struct StaffAcheivements: Codable {
    var acheivements: [StaffAcheivement]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case acheivements = "sjcc_staffachievement", success = "success", message = "message"
    }
}

struct StudentAnnouncements: Codable {
    var announcements: [ParentsAnnouncement]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case announcements = "student_announcement", message = "message", success = "success"
    }
}

struct StudentExaminations: Codable {
    var examinations: [ParentsAnnouncement]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case examinations = "student_examination", message = "message", success = "success"
    }
}

struct StudentActivities: Codable {
    var activities: [News]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case activities = "sjcc_stdactivities", success = "success", message = "message"
    }
}

struct StudentPlacementCell: Codable {
    var placements: [TeacherMeeting]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case placements = "placement", success = "success", message = "message"
    }
}

struct StudentWrites: Codable {
    var writes: [News]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case writes = "sjcc_writes", success = "success", message = "message"
    }
}

struct StudentDownloads: Codable {
    var downloads: [ParentsAnnouncement]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case downloads = "downloads", message = "message", success = "success"
    }
}

struct StudentLogin: Codable {
    var id: String
    var regNo: String
    var phone: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", regNo = "regno", phone = "phone"
    }
}

struct StudentLoginData: Codable {
    var student: [StudentLogin]
    var message: String
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case student = "student_login", message = "message", success = "success"
    }
}

// MARK:- Parser
class Parser {
    static let sharedInstance = Parser()
    private init() {}
    
    internal func parseHomeGallery(_ jsonString: String, onSuccess: ([HomeGallery]) -> Void) {
        do {
            let decodeddata = try JSONDecoder().decode(GalleryArray.self, from: Data(jsonString.utf8))
            var gallery: [HomeGallery] = []
            for photo in decodeddata.sjccPhotos {
                let homeGallery = HomeGallery(id: photo.id, title: photo.title, image: photo.image, updatedAt: photo.updatedAt)
                gallery.append(homeGallery)
            }
            onSuccess(gallery)
        } catch {
            print(error)
        }
    }
    
    internal func parseNews(_ jsonString: String, onSuccess: ([News]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(NewsArray.self, from: Data(jsonString.utf8))
            var newsData: [News] = []
            for news in decodedData.news {
                let newsObject = News(id: news.id, title: news.title, image: news.image, updatedAt: news.updatedAt, date: news.date, description: news.description)
                newsData.append(newsObject)
            }
            onSuccess(newsData)
        } catch {
            print(error)
        }
    }
    
    internal func parseNotifications(_ jsonString: String, onSuccess: ([Notification]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(Notifications.self, from: Data(jsonString.utf8))
            var notifications: [Notification] = []
            for notification in decodedData.sjccNotifications {
                let notificationObject = Notification(id: notification.id, title: notification.title, date: notification.date, topicName: notification.topicName, description: notification.description, updatedAt: notification.updatedAt)
                notifications.append(notificationObject)
            }
            onSuccess(notifications)
        } catch {
            print(error)
        }
    }
    
    private func getAnnouncements(announcements: ([ParentsAnnouncement])) -> [ParentsAnnouncement] {
        var announcementsArray: [ParentsAnnouncement] = []
        for announcement in announcements {
            let announcementObject = ParentsAnnouncement(id: announcement.id, title: announcement.title, date: announcement.date, pdf: announcement.pdf, updatedAt: announcement.updatedAt)
            announcementsArray.append(announcementObject)
        }
        return announcementsArray
    }
    
    internal func parseParentsAnnouncements(_ jsonString: String, onSuccess: ([ParentsAnnouncement]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(ParentsAnnouncements.self, from: Data(jsonString.utf8))
            onSuccess(getAnnouncements(announcements: decodedData.announcements))
        } catch {
            print(error)
        }
    }
    
    private func getBasicModelData(data: [BasicModel]) -> [BasicModel] {
        var programActivities: [BasicModel] = []
        for activity in data {
            let activityObject = BasicModel(id: activity.id, title: activity.title, description: activity.description, updatedAt: activity.updatedAt)
            programActivities.append(activityObject)
        }
        return programActivities
    }
    
    internal func parseProgramActivityList(_ jsonString: String, onSuccess: ([BasicModel]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(ProgramActivity.self, from: Data(jsonString.utf8))
            onSuccess(getBasicModelData(data: decodedData.programActivity))
        } catch {
            print(error)
        }
    }
    
    internal func parseCollegeRules(_ jsonString: String, onSuccess: ([BasicModel]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(CollegeRules.self, from: Data(jsonString.utf8))
            onSuccess(getBasicModelData(data: decodedData.rules))
        } catch {
            print(error)
        }
    }
    
    internal func parseTeacherMeetings(_ jsonString: String, onSuccess: ([TeacherMeeting]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(TeacherMeetings.self, from: Data(jsonString.utf8))
            var meetings: [TeacherMeeting] = []
            for meeting in decodedData.meetings {
                let teacherMeeting = TeacherMeeting(id: meeting.id, title: meeting.title, date: meeting.date, description: meeting.description, updatedAt: meeting.updatedAt)
                meetings.append(teacherMeeting)
            }
            onSuccess(meetings)
        } catch {
            print(error)
        }
    }
    
    internal func parseOutReachPrograms(_ jsonString: String, onSuccess: ([News]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(OutReachPrograms.self, from: Data(jsonString.utf8))
            var programs: [News] = []
            for program in decodedData.programs {
                let outReachProgram = News(id: program.id, title: program.title, image: program.image, updatedAt: program.updatedAt, date: program.date, description: program.description)
                programs.append(outReachProgram)
            }
            onSuccess(programs)
        } catch {
            print(error)
        }
    }
    
    internal func parseOfficeBearers(_  jsonString: String, onSuccess: ([OfficeBearer]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(OfficeBearers.self, from: Data(jsonString.utf8))
            var bearers: [OfficeBearer] = []
            for bearer in decodedData.bearers {
                let officeBearer = OfficeBearer(id: bearer.id, name: bearer.name, designation: bearer.designation, image: bearer.image, updatedAt: bearer.updatedAt)
                bearers.append(officeBearer)
            }
            onSuccess(bearers)
        } catch {
            print(error)
        }
    }
    
    internal func parseAluminiAcivities(_ jsonString: String, onSuccess: ([TeacherMeeting]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(AluminiActivities.self, from: Data(jsonString.utf8))
            var activities: [TeacherMeeting] = []
            for activity in decodedData.activities {
                let aluminiActivity = TeacherMeeting(id: activity.id, title: activity.title, date: activity.date, description: activity.description, updatedAt: activity.updatedAt)
                activities.append(aluminiActivity)
            }
            onSuccess(activities)
        } catch {
            print(error)
        }
    }
    
    private func parseLetters(lettersList: [NewsLetter]) -> [NewsLetter] {
        var letters: [NewsLetter] = []
        for letter in lettersList {
            let newsLetter = NewsLetter(id: letter.id, image: letter.image, title: letter.title, date: letter.date, pdf: letter.pdf, updatedAt: letter.updatedAt)
            letters.append(newsLetter)
        }
        return letters
    }
    
    internal func parseNewsLetter(_ jsonString: String, onSuccess:([NewsLetter]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(NewsLetters.self, from: Data(jsonString.utf8))
            onSuccess(parseLetters(lettersList: decodedData.letters))
        } catch {
            print(error)
        }
    }
    
    internal func parseGalleryFullImageList(_ jsonString: String, onSucceess: ([GalleryFullImage]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(GalleryFullImageList.self, from: Data(jsonString.utf8))
            var galleryList: [GalleryFullImage] = []
            for galleryItem in decodedData.images {
                let galleryFullImage = GalleryFullImage(id: galleryItem.id, pId: galleryItem.pId, image: galleryItem.image, updatedAt: galleryItem.updatedAt)
                galleryList.append(galleryFullImage)
            }
            onSucceess(galleryList)
        } catch {
            print(error)
        }
    }
    
    internal func parseProspectUs(_ jsonString: String, onSuccess: ([NewsLetter]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(ProspectUs.self, from: Data(jsonString.utf8))
            onSuccess(parseLetters(lettersList: decodedData.prospectList))
        } catch {
            print(error)
        }
    }
    
    internal func parseAnnouncements(_ jsonString: String, onSuccess: ([ParentsAnnouncement]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(Announcements.self, from: Data(jsonString.utf8))
            onSuccess(getAnnouncements(announcements: decodedData.announcements))
        } catch {
            print(error)
        }
    }
    
    internal func parseManagementList(_ jsonString: String, onSuccess: ([Management]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(ManagementList.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.list)
        } catch {
            print(error)
        }
    }
    
    internal func parseGoverningBodies(_ jsonString: String, onSuccess: ([GoverningBody]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(GoverningBodies.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.bodies)
        } catch {
            print(error)
        }
    }
    
    internal func parseStaffLogin(_ jsonString: String, onSuccess: (Int) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StaffLoginData.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.success)
        } catch {
            print(error)
        }
    }
    
    internal func parseStaffRules(_ jsonString: String, onSuccess: ([TeacherMeeting]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StaffRules.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.rules)
        } catch {
            print(error)
        }
    }
    
    internal func parseStaffDuties(_ jsonString: String, onSuccess: ([NewsLetter]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StaffDuties.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.duties)
        } catch {
            print(error)
        }
    }
    
    internal func parseStaffSeminars(_ jsonString: String, onSuccess: ([NewsLetter]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StaffSeminars.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.seminars)
        } catch {
            print(error)
        }
    }
    
    internal func parseStaffCalendars(_ jsonString: String, onSuccess: ([StaffCalendar]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StaffCalendars.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.calendars)
        } catch {
            print(error)
        }
    }
    
    internal func parseStaffRemainders(_ jsonString: String, onSuccess: ([ParentsAnnouncement]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StaffRemainderAnnouncements.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.remainders)
        } catch {
            print(error)
        }
    }
    
    internal func parseStaffAcheivements(_ jsonString: String, onSuccess: ([StaffAcheivement]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StaffAcheivements.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.acheivements)
        } catch {
            print(error)
        }
    }
    
    internal func parseStudentLoginDetails(_ jsonString: String, onSuccess: (Int) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StudentLoginData.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.success)
        } catch {
            print(error)
        }
    }
    
    internal func parseStudentAnnouncements(_ jsonString: String, onSuccess: ([ParentsAnnouncement]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StudentAnnouncements.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.announcements)
        } catch {
            print(error)
        }
    }
    
    internal func parseStudentExaminations(_ jsonString: String, onSuccess: ([ParentsAnnouncement]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StudentExaminations.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.examinations)
        } catch {
            print(error)
        }
    }
    
    internal func parseStudentActivities(_ jsonString: String, onSuccess: ([News]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StudentActivities.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.activities)
        } catch {
            print(error)
        }
    }
    
    internal func parseStudentPlacements(_ jsonString: String, onSuccess: ([TeacherMeeting]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StudentPlacementCell.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.placements)
        } catch {
            print(error)
        }
    }
    
    internal func parseStudentWrites(_ jsonString: String, onSuccess: ([News]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StudentWrites.self, from: Data(jsonString.utf8))
            onSuccess(decodedData.writes)
        } catch {
            print(error)
        }
    }
    
    internal func parseStudentDownloads(_ jsonsString: String, onSuccess: ([ParentsAnnouncement]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(StudentDownloads.self, from: Data(jsonsString.utf8))
            onSuccess(decodedData.downloads)
        } catch {
            print(error)
        }
    }
}
