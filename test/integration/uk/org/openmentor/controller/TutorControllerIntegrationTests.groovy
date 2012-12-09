package uk.org.openmentor.controller

import java.util.Map;

import grails.test.*

import org.gmock.WithGMock
import uk.org.openmentor.courseinfo.Tutor

@WithGMock
class TutorControllerIntegrationTests extends GroovyTestCase {
	
	TutorController controller
	
	Map savedMetaClasses = [:]
	Map renderMap
	Map redirectMap

    protected void setUp() {
        super.setUp()

		registerMetaClass(TutorController.class)
		TutorController.metaClass.render = {Map m ->
			renderMap = m
		}
		TutorController.metaClass.redirect = {Map m ->
			redirectMap = m
		}

		controller = new TutorController()
    }

    protected void tearDown() {
        super.tearDown()
    }
	
	/**
	 * Test the create action
	 */
	void testCreateAction() {
		controller.create()
		
		assertNull(renderMap)
		assertNull(redirectMap)
	}
	
	/**
	 * Test the edit action
	 */
	void testEditAction() {
		controller.params.id = 'M4000061'
		def model = controller.edit()
		
		assertEquals 'M4000061', model.tutorInstance?.tutorId
	}

	/**
	 * Test the show action
	 */
	void testShowAction() {
		controller.params.id = 'M4000061'
		def model = controller.show()
		
		assertEquals 'M4000061', model.tutorInstance?.tutorId
	}

	/**
	 * Test the list action
	 */
	void testListAction() {
		def model = controller.list()
		
		assertEquals 3, model.tutorInstanceTotal
		assertTrue model.tutorInstanceList.every { it instanceof Tutor }
	}

	// Stolen from GrailsUnitTestCase
	/**
	 * Use this method when you plan to perform some meta-programming
	 * on a class. It ensures that any modifications you make will be
	 * cleared at the end of the test.
	 * @param clazz The class to register.
	 */
	protected void registerMetaClass(Class clazz) {
		// If the class has already been registered, then there's
		// nothing to do.
		if (savedMetaClasses.containsKey(clazz)) return

		// Save the class's current meta class.
		savedMetaClasses[clazz] = clazz.metaClass

		// Create a new EMC for the class and attach it.
		def emc = new ExpandoMetaClass(clazz, true, true)
		emc.initialize()
		GroovySystem.metaClassRegistry.setMetaClass(clazz, emc)
	}

}