//
//  ListTableViewController.swift
//  Sumurai
//
//  Created by Cole Ramos on 7/29/19.
//  Copyright © 2019 CodeBusters IC. All rights reserved.
//

import Foundation
import UIKit
import Cards

class ListTableViewController: UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 600
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionTitles.count
    }
    
//    let sectionTitles = UserDefaults.standard.array(forKey: "SectionHeaders")
//    let sectionContent = UserDefaults.standard.array(forKey: "SummarisedSections")
    
    let sectionTitles = ["Introduction","Methodology","Results and Data Analysis", "Discussion"]
    let sectionContent = ["We believe that a study of students’ opinions on and attitudes towards reading literature may be a reliable barometer of the changes undergone by philological instruction in Romanian higher education institutions. Before the educational reform initiated within the Bologna process in 2005, the teaching of literature was steeped in the traditional lecture and examination method. [...] Most often, such a conservative conception of teaching literature did not place much stress on developing students’ ability to deal with literary texts through careful reading and specific classroom activities, but on memorizing a large number of literary analyses viewed as models of critical thinking. [...] Promoting a new model of interacting with literary texts, the teaching of literature may foster a more responsible attitude towards reading in students.","The purpose of our paper is to discover if students read the works required by their literature syllabus, and to analyse their views about the usefulness and importance of reading literature. In the context of the new classroom treatment of literature, we had in view three research questions: i)To what extent do students read the works of literature they have to study? ii)To what extent do students read abbreviated versions of books, plot summaries and literary commentaries instead of the works of literature they have to study? [...] These are the cultural model (students have access to different cultures broadening their horizons), the language model (the study of literature promotes language development) and the personal growth model which consists in making “the reading of literature a memorable, individual and collective experience” that is “renewed” as students “continue to engage with literature throughout their lives”.","The respondents’ answers to the questionnaire were relevant to the purpose of our research as they brought to light a multitude of opinions. The answers to question one pointed out one major drawback of the teaching and learning approaches to literature in our institution. As seen from answers A and B, only 45% of students manage to read all or almost all the works included in the literature syllabus, whereas the majority of learners (55%) confine themselves to reading this material partially or insufficiently. In the case of item two (Enumerate several problems related to your literature syllabus and find solutions to these problems), most answers converge to the idea that the literature syllabus is overloaded: “I can’t cope with a huge number of authors”, “Literature programmes contain too many writers,” “We need to read a lot of books in a limited time”, etc. It is also important to mention that, according to the majority of our respondents, the solution to heavy workload consists in reading abbreviated versions of books, plot summaries and literary commentaries. As far as question three is concerned, we should remark that students’ present attitude towards reading literature is not different from the high school period. [...] Other significant data were provided by students’ answers to question four, which refers to their perceptions of the importance of reading the literary works included in the current syllabus. [...] With regard to question five, which concerns students’ opinions about the way in which they should improve their attitudes to reading literature, their suggestions range from the superficial level to real determination (“I will read the writers I like”, “I will try to read the authors and the books studied in class”, “I will dedicate my spare time to reading the bibliography required by my teachers for courses and seminars”, “I will adopt a more systematic study of the literary works required by my teachers”, etc ).. [...] As to question eight, 63 % of our respondents prefer studying language to literature. [...] As our respondents will get a bachelor’s degree in language and literature studies this year, question nine concerned their role as literature teachers (If you were a literature teacher, what strategies would you adopt during your lessons?).","The findings of our research show that most students specializing in languages and literary studies within the Department of Philology of our university are not motivated to invest effort and time in reading the works of literature included in the syllabus. Students’ lack of interest in literature is due to multiple objective and subjective causes. Among the most significant factors contributing to their demotivation for reading and for the instructional process in general are the educational policies of universities which, according to the Romanian Agency for Quality Assurance in Higher Education, lay “emphasis on research rather than teaching or students’ performance” because they are compelled “to attach great importance to indicators of research performance, to the detriment of students’ current needs and concerns.” As the same report points out, the most common perception is that the prioritization of teaching is the expression of the fact that a university “cannot reach superior standards in research, which is equivalent to a ‘penalty’ in terms of reputation.”(2010:20) As the ultimate goal of universities is to become research centers of excellence, improving the quality of the teaching and learning process is considered to be of secondary importance or is even overlooked by the academic staff. Contrary to this general opinion, we believe that research and teaching in higher education are closely interrelated, both leading to high standards of quality and finally to the prestige of a university. [...] Owing to the artificial separation between research and teaching in academic education, the teaching of literature has remained attached to traditional instructional values which, in most cases, do not manage to stimulate learners’ interests and intellect. [...] However, linguistic knowledge is a necessary but not sufficient condition for the teaching profession as, on the one hand, language cannot be separated from its literary and cultural context, and, on the other hand, literature is an indispensable component of the philological curriculum whose aim is not only to build specific skills but also to equip students with the universal values of human culture. Of course, we may change students’ unfavorable perception of literature into a positive attitude only by putting greater emphasis on “quality teaching”, that is, by adopting “a set of actions and activities that improve student outcome”. [...] In short, using the lecture as the only mode of teaching literature in higher education in general, and in our institution in particular, has a negative impact on students who, according to our findings, wish to be involved in a dynamic literature class."]
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let card = cell.viewWithTag(1000) as! CardArticle
        let cardContent = storyboard!.instantiateViewController(withIdentifier: "SectionContent")
        card.shouldPresent(cardContent, from: self, fullscreen: true)
        card.backgroundImage = UIImage(named: "dojo_on_mountain")
        card.title = sectionTitles[indexPath.row] as! String
        card.category = ""
        UserDefaults.standard.set(sectionContent[indexPath.row], forKey: "content")
        //card.subtitle = sectionContent[indexPath.row]
        return cell
    }
    
}
