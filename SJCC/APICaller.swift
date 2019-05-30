//
//  APICaller.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 24/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation

typealias OnSuccessResponse = (String) -> Void
typealias OnDestroySuccess = () -> Void
typealias OnCancelSuccess = () -> Void
typealias OnErrorMessage = (String) -> Void

typealias JSONDictionary = [String : AnyObject]

private enum RequestMethod: String, CustomStringConvertible {
    case GET = "GET"
    case PUT = "PUT"
    case POST = "POST"
    case DELETE = "DELETE"
    case PATCH  = "PATCH"
    
    var description: String {
        return rawValue
    }
}

class APICaller {
    let MAX_RETRIES = 2
    
    fileprivate var urlSession: URLSession
    
    class func getInstance() -> APICaller {
        struct Static {
            static let instance = APICaller()
        }
        return Static.instance
    }
    
    fileprivate init() {
        urlSession = APICaller.createURLSession()
    }
    
    fileprivate class func createURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.urlCache = nil
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    fileprivate func resetURLSession() {
        urlSession.invalidateAndCancel()
        urlSession = APICaller.createURLSession()
    }
    
    fileprivate func createRequest(_ requestMethod: RequestMethod, _ route: Route, params: JSONDictionary? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: route.absoluteURL as URL)
        request.httpMethod = requestMethod.rawValue
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        if let params = params {
            switch requestMethod {
            case .GET, .DELETE:
                var queryItems: [URLQueryItem] = []
                
                for (key, value) in params {
                    queryItems.append(URLQueryItem(name: "\(key)", value: "\(value)"))
                }
                
                if queryItems.count > 0 {
                    var components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
                    components?.queryItems = queryItems
                    request.url = components?.url
                }
                
            case .POST, .PUT, .PATCH:
                var bodyParams = ""
                for (key, value) in params {
                    bodyParams += "\(key)=" + "\(value)"
                    bodyParams = bodyParams + "&"
                }
                let postData = bodyParams.data(using: String.Encoding.ascii, allowLossyConversion: true)!
                //let body = try JSONSerialization.data(withJSONObject: params, options: [])
                request.httpBody = postData
            }
        }
        return request as URLRequest
    }
    
    fileprivate func enqueueRequest(_ requestMethod: RequestMethod, _ route: Route, params: JSONDictionary? = nil, retryCount: Int = 0, onSuccessResponse: @escaping (String) -> Void, onErrorMessage: @escaping OnErrorMessage) {
        
        let urlRequest = createRequest(requestMethod, route, params: params)
        print("URL-> \(urlRequest)")
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                var statusCode = httpResponse.statusCode
                var responseString:String = ""
                if let responseData = data {
                    responseString = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue) as String? ?? ""
                }else {
                    statusCode = 450
                }
                print(responseString)
                switch statusCode {
                case 200...299:
                    // Success Response
                    onSuccessResponse(responseString)
                  
                default:
                    // Failure Response
                    let errorMessage = "Error Code: \(statusCode)"
                    onErrorMessage(errorMessage)
                }
            } else if let error = error {
                var errorMessage: String
                switch error._code {
                case NSURLErrorNotConnectedToInternet:
                    errorMessage = "Net Lost"//Constant.ErrorMessage.InternetConnectionLost
                case NSURLErrorNetworkConnectionLost:
                    if retryCount < self.MAX_RETRIES {
                        self.enqueueRequest(requestMethod, route, params: params, retryCount: retryCount + 1, onSuccessResponse: onSuccessResponse, onErrorMessage: onErrorMessage)
                        return
                    } else {
                        errorMessage = error.localizedDescription
                    }
                default:
                    errorMessage = error.localizedDescription
                }
                onErrorMessage(errorMessage)
            } else {
                assertionFailure("Either an httpResponse or an error is expected")
            }
        })
        dataTask.resume()
    }
    
    internal func getHomeGallery(onSuccess: @escaping ([HomeGallery]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(
            .POST, .homeGallery, params: ["updated_at" : "2018-02-03 02:15:49" as AnyObject],
            onSuccessResponse: { response in
                Parser.sharedInstance.parseHomeGallery(response, onSuccess: { gallery in
                    onSuccess(gallery)
                })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getNews(onSuccess: @escaping ([News]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(
            .POST, .news, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
                Parser.sharedInstance.parseNews(response, onSuccess: { news in
                    onSuccess(news)
                })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getNotifications(onSuccess: @escaping ([Notification]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(
            .POST, .notifications, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
                Parser.sharedInstance.parseNotifications(response, onSuccess: { notifications in
                    onSuccess(notifications)
                })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getAnnouncementsList(onSuccess: @escaping ([ParentsAnnouncement]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .parentsAnnouncements, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseParentsAnnouncements(response, onSuccess: { announcements in
                onSuccess(announcements)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getProgramActivity(onSuccess: @escaping ([BasicModel]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .programActivity, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseProgramActivityList(response, onSuccess: { activities in
                onSuccess(activities)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getCollegeRules(onSuccess: @escaping ([BasicModel]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .collegeRules, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseCollegeRules(response, onSuccess: { rules in
                onSuccess(rules)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getParentsTeachersMettingList(onSuccess: @escaping ([TeacherMeeting]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .teacherMeetings, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseTeacherMeetings(response, onSuccess: { meetings in
                onSuccess(meetings)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getOutreachPrograms(onSuccess: @escaping ([News]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .outreachProgramList, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseOutReachPrograms(response, onSuccess: {programs in
                onSuccess(programs)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getAluminiOfficeBeares(onSuccess: @escaping ([OfficeBearer]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .aluminiOfficeBearers, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseOfficeBearers(response, onSuccess: { bearers in
                onSuccess(bearers)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getAluminiAssociationActivities(onSuccess: @escaping ([TeacherMeeting]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .aluminiAssociationActivities, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseAluminiAcivities(response, onSuccess: { activities in
                onSuccess(activities)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getNewsLetter(onSuccess: @escaping ([NewsLetter]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .newsLetter, onSuccessResponse: { response in
            Parser.sharedInstance.parseNewsLetter(response, onSuccess: { letters in
                onSuccess(letters)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getGalleryImageList(photoId: String, onSuccess: @escaping ([GalleryFullImage]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(
            .POST, .galleryImageList, params: ["p_id" : photoId as AnyObject],
            onSuccessResponse: { response in
                Parser.sharedInstance.parseGalleryFullImageList(response, onSucceess: { list in
                    onSuccess(list)
                })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getProspectUsList(onSuccess: @escaping ([NewsLetter]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .prospectUs, onSuccessResponse: { response in
            Parser.sharedInstance.parseProspectUs(response, onSuccess: { list in
                onSuccess(list)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getAnnouncements(onSuccess: @escaping ([ParentsAnnouncement]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .announcements, onSuccessResponse: { response in
            Parser.sharedInstance.parseAnnouncements(response, onSuccess: { announcemnets in
                onSuccess(announcemnets)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getManagementList(onSuccess: @escaping ([Management]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .management, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseManagementList(response, onSuccess: { list in
                onSuccess(list)
            })
        }, onErrorMessage: {error in
            onError(error)
        })
    }
    
    internal func getGoverningBodyList(onSuccess: @escaping ([GoverningBody]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .governingBody, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseGoverningBodies(response, onSuccess: { bodies in
                onSuccess(bodies)
            })
        }, onErrorMessage: {error in
            onError(error)
        })
    }
    
    internal func getGoverningIndividual(id: String, onSuccess: @escaping ([GoverningBody]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .governingIndividual, onSuccessResponse: { response in
            
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getStaffloginDetails(email: String, password: String, onSuccess: @escaping (Int) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .staffLogin, params: ["email" : email as AnyObject, "password" : password as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseStaffLogin(response, onSuccess: { success in
                onSuccess(success)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getStaffAcheivementList(onSuccess: @escaping ([StaffAcheivement]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .staffAchievementList, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseStaffAcheivements(response, onSuccess: { acheivements in
                onSuccess(acheivements)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getStaffRemainderAnnouncementList(onSuccess: @escaping ([ParentsAnnouncement]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .staffAnnouncementList, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseStaffRemainders(response, onSuccess: { remainders in
                onSuccess(remainders)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getStaffDutiesList(onSuccess: @escaping ([NewsLetter]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .staffDuties, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseStaffDuties(response, onSuccess: { duties in
                onSuccess(duties)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getStaffRulesList(onSuccess: @escaping ([TeacherMeeting]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .staffRules, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseStaffRules(response, onSuccess: { rules in
                onSuccess(rules)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getStaffSeminarList(onSuccess: @escaping ([NewsLetter]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .staffSeminar, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseStaffSeminars(response, onSuccess: { seminars in
                onSuccess(seminars)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getStaffAcademicCalendar(onSuccess: @escaping ([StaffCalendar]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .staffAcademicCalendar, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseStaffCalendars(response, onSuccess: { calendars in
                onSuccess(calendars)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getStudentLoginDetails(registeredNumber: String, phoneNumber: String, onSuccess: @escaping (Int) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .studentLogin, params: ["regno" : registeredNumber as AnyObject, "phone" : phoneNumber as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseStudentLoginDetails(response, onSuccess: { success in
                onSuccess(success)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getStudentAnnouncements(onSuccess: @escaping ([ParentsAnnouncement]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .studentAnnouncements, params: ["updated_at" : "2019-01-10 22:48:29" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseStudentAnnouncements(response, onSuccess: { announcements in
                onSuccess(announcements)
            })
        }) { (error) in
            onError(error)
        }
    }
    
    internal func getStudentExaminations(onSuccess: @escaping ([ParentsAnnouncement]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .studentExaminations, onSuccessResponse: { (response) in
            Parser.sharedInstance.parseStudentExaminations(response, onSuccess: { examinations in
                onSuccess(examinations)
            })
        }) { (error) in
            onError(error)
        }
    }
    
    internal func getStudentActivites(onSuccess: @escaping ([News]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .studentActivities, onSuccessResponse: { (response) in
            Parser.sharedInstance.parseStudentActivities(response, onSuccess: { activites in
                onSuccess(activites)
            })
        }) { (error) in
            onError(error)
        }
    }
    
    internal func getStudentPlacementCell(onSuccess: @escaping ([TeacherMeeting]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .studentPlacementCell, onSuccessResponse: { (response) in
            Parser.sharedInstance.parseStudentPlacements(response, onSuccess: { placements in
                onSuccess(placements)
            })
        }) { (error) in
            onError(error)
        }
    }
    
    internal func getStudentDownloads(onSuccess: @escaping ([ParentsAnnouncement]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .studentDownloads, onSuccessResponse: { (response) in
            Parser.sharedInstance.parseStudentDownloads(response, onSuccess: { downloads in
                onSuccess(downloads)
            })
        }) { (error) in
            onError(error)
        }
    }
    
    internal func getStudentSjccWrites(onSuccess: @escaping ([News]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .studentSjccWrites, onSuccessResponse: { (response) in
            Parser.sharedInstance.parseStudentWrites(response, onSuccess: { writes in
                onSuccess(writes)
            })
        }) { (error) in
            onError(error)
        }
    }
}
