//
//  MyEventsViewController.swift
//  Synapse
//
//  Created by Zack Noble on 2/17/20.
//  Copyright © 2020 Synapse. All rights reserved.
//

import UIKit

class MyEventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    struct Events {
        var sectionHeader: String!
        var sectionEvents = [Event]()
    }
    
    var receivedEventArray = [Event]()
    var eventsArray = [Events]()
    var currentEventsArray = [Events]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEvents()
    }
    
    private func setUpEvents(){
        //Create a Date with the current calendar date with the time set to midnight
        let date1 = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        
        //Calculate the Date objects for the next week
        let date2 = date1.addingTimeInterval(86400);
        let date3 = date2.addingTimeInterval(86400);
        let date4 = date3.addingTimeInterval(86400);
        let date5 = date4.addingTimeInterval(86400);
        let date6 = date5.addingTimeInterval(86400);
        let date7 = date6.addingTimeInterval(86400);
        
        //Create Strings for the week's dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let day3String = dateFormatter.string(from: date3)
        let day4String = dateFormatter.string(from: date4)
        let day5String = dateFormatter.string(from: date5)
        let day6String = dateFormatter.string(from: date6)
        let day7String = dateFormatter.string(from: date7)
        
        receivedEventArray.append(Event(purpose: "Go over homework 1", date: date4, time: "10:00 AM", classCode: "MATH2800"));
        receivedEventArray.append(Event(purpose: "Study for test", date: date3, time: "10:00 AM", classCode: "CS3250"));
        receivedEventArray.append(Event(purpose: "Work on programming assignment 4 with study team", date: date6, time: "10:00 AM", classCode: "CS3251"));
        receivedEventArray.append(Event(purpose: "Make studyguide", date: date2, time: "10:00 AM", classCode: "HIST1501"));
        receivedEventArray.append(Event(purpose: "Go over homework 1", date: date5, time: "10:00 AM", classCode: "MATH1200"));
        receivedEventArray.append(Event(purpose: "Study for test", date: date1, time: "10:00 AM", classCode: "ENGL1602"));
        receivedEventArray.append(Event(purpose: "Quiz each other with flashcards", date: date1, time: "10:00 AM", classCode: "ENGL1602"));
        receivedEventArray.append(Event(purpose: "Go to office hours", date: date7, time: "10:00 AM", classCode:"CS3250"));
        
        //Current date and time
        
        eventsArray = [Events(sectionHeader: "Today", sectionEvents:[]),
                       Events(sectionHeader: "Tomorrow", sectionEvents:[]),
                       Events(sectionHeader: day3String, sectionEvents:[]),
                       Events(sectionHeader: day4String, sectionEvents:[]),
                       Events(sectionHeader: day5String, sectionEvents:[]),
                       Events(sectionHeader: day6String, sectionEvents:[]),
                       Events(sectionHeader: day7String, sectionEvents:[])];
        
        for eventObject in receivedEventArray{
            let dt = eventObject.date;
            let diffInDays = Calendar.current.dateComponents([.day], from: date1, to: dt).day;
            eventsArray[diffInDays!].sectionEvents.append(eventObject);
        }
        
        currentEventsArray = eventsArray
        
    }
    
    //Table Section Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let label = UILabel(frame: CGRect(x: 15, y: 5, width: tableView.frame.width, height: 20))
        
        label.text = eventsArray[section].sectionHeader
        view.backgroundColor = UIColor(hexString: "6200EE")
        label.textColor = UIColor.white
        
        label.font = UIFont(name: "Avenir", size: 16)
        view.addSubview(label)
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return currentEventsArray.count
    }
    
     //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentEventsArray[section].sectionEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyEventsTableViewCell") as? MyEventsTableViewCell else {
            return UITableViewCell()
        }
        
        
        //Create the DateFormatter for the date field within a table cell
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        //Change the names of these labels to reflect the new content they hold (i.e. the header is the
        //  class instead of the purpose, the the place where the date was now holds the purpose)
        cell.classLabel.text = eventsArray[indexPath.section].sectionEvents[indexPath.row].classCode
        cell.dateLabel.text = eventsArray[indexPath.section].sectionEvents[indexPath.row].purpose
        cell.timeLabel.text = eventsArray[indexPath.section].sectionEvents[indexPath.row].time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}