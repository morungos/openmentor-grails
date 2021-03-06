package uk.org.openmentor.config

import java.util.List;

class Grade {
		
	String id

    static constraints = {
		id(nullable: false, blank: false, unique: true, maxSize: 12, bindable: true)
    }
	
	static mapping = {
		id column:'grade', generator: 'assigned'
	}

	static List<Grade> getGrades() {
		return Grade.findAll()
	}
}
