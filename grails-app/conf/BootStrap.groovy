import uk.org.openmentor.courseinfo.Course
import uk.org.openmentor.courseinfo.Student
import uk.org.openmentor.courseinfo.Tutor
import uk.org.openmentor.data.Assignment
import uk.org.openmentor.auth.Role
import uk.org.openmentor.auth.User
import uk.org.openmentor.auth.UserRole
import uk.org.openmentor.system.DataSourceUtils
import grails.util.Environment
import org.apache.log4j.Logger

class BootStrap {
	
	static final Logger log = Logger.getLogger(this)
	
	def springSecurityService

	def init = { servletContext ->
		DataSourceUtils.tune(servletContext)
		
		switch (Environment.current) {
			
			case Environment.DEVELOPMENT:
				seedTestData()
				break;
			
			case Environment.TEST:
				seedTestData()
				break;
			
			case Environment.PRODUCTION:
				break;
		}

		seedUserData()
	}

	def destroy = {
    }
	
	/**
	 * Initializes the user data, ensuring that all required roles exist, and that an 
	 * user "admin" exists if it doesn't already. It is initially created with a password
	 * "admin", that probably ought to be changed. That probably requires an interface. 
	 */
	private void seedUserData() {
		
		def userRole = Role.findByAuthority('ROLE_OPENMENTOR-USERS') ?: new Role(authority: 'ROLE_OPENMENTOR-USERS').save(failOnError: true)
		def adminRole = Role.findByAuthority('ROLE_OPENMENTOR-ADMIN') ?: new Role(authority: 'ROLE_OPENMENTOR-ADMIN').save(failOnError: true)

		def adminUser = User.findByUsername('admin') ?: new User(
			username: 'admin',
			password: springSecurityService.encodePassword('admin'),
			enabled: true).save(failOnError: true)
			
		if (! adminUser.authorities.contains(adminRole)) {
			UserRole.create adminUser, adminRole
		}
	}
	
	/**
	 * When run in test or development mode, create a few courses, students, and 
	 * tutors, ready to test out the rest of the system. 
	 */
	private void seedTestData() {
		// Seed only when there's no data
		if (Course.count() == 0) {
			
			def courseCM2006 = new Course(courseId: "CM2006", courseTitle: "Interface Design")
			courseCM2006.save(failOnError:true)

			def student09000231 = new Student(studentId: "09000231", givenName: "Gwenda", familyName: "Blane")
			student09000231.save(failOnError:true)

			def student09000232 = new Student(studentId: "09000232", givenName: "Fred", familyName: "Zucker")
			student09000232.save(failOnError:true)

			def student09000233 = new Student(studentId: "09000233", givenName: "Caitlyn", familyName: "Respass")
			student09000233.save(failOnError:true)

			def student09000234 = new Student(studentId: "09000234", givenName: "Luke", familyName: "Naccarato")
			student09000234.save(failOnError:true)

			def tutorM4000061 = new Tutor(tutorId: "M4000061", givenName: "Zena", familyName: "Beatrice")
			tutorM4000061.save(failOnError:true)

			def tutorM4000062 = new Tutor(tutorId: "M4000062", givenName: "Levi", familyName: "Evert")
			tutorM4000061.save(failOnError:true)

			def tutorM4000063 = new Tutor(tutorId: "M4000063", givenName: "Jeanie", familyName: "Denman")
			tutorM4000061.save(failOnError:true)
			
			courseCM2006.addToStudents(student09000231)
			courseCM2006.addToStudents(student09000232)
			courseCM2006.addToStudents(student09000233)
			courseCM2006.addToStudents(student09000234)

			courseCM2006.addToTutors(tutorM4000061)
			courseCM2006.addToTutors(tutorM4000062)
			courseCM2006.addToTutors(tutorM4000063)
			courseCM2006.save(failOnError:true)

			def assignment1 = new Assignment(courseId: courseCM2006.courseId, code: "TMA01").save(failOnError:true)
			def assignment2 = new Assignment(courseId: courseCM2006.courseId, code: "TMA02").save(failOnError:true)
			def assignment3 = new Assignment(courseId: courseCM2006.courseId, code: "TMA03").save(failOnError:true)
			def assignment4 = new Assignment(courseId: "DD303", code: "TMA01").save(failOnError:true)
		}
	}
}
