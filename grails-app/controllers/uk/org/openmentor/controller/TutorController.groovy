package uk.org.openmentor.controller

import uk.org.openmentor.courseinfo.Tutor;

class TutorController {

    def index = { 
		redirect(action: "list", params: params)
	}

	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = params.sort ?: 'tutorId'
		params.order = params.order ?: 'asc'
		params.offset = params.offset ?: '0'
				
		def criteria = Tutor.createCriteria()
		
		def tutorList = criteria.list {
			order(params.sort, params.order)
			maxResults(params.max)
			firstResult(Integer.parseInt(params.offset))
		}
		
		def tutorCount = Tutor.count()
		
		[tutorInstanceList: tutorList, tutorInstanceTotal: tutorCount]
	}

	def save = {
		def tutorInstance = new Tutor(params)
		
		if (tutorInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'tutor.label', default: 'Tutor'), tutorInstance.tutorId])}"
			redirect(action: "list", id: tutorInstance.tutorId)
		}
		else {
			log.info("Failed to create new tutor: returning to dialog")
			render(view: "create", model: [tutorInstance: tutorInstance])
		}
	}
	
	def show = {
		def tutorInstance = Tutor.get(params.id)
        if (!tutorInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tutor.label', default: 'Tutor'), params.id])}"
            redirect(action: "list")
        }
        else {
            [tutorInstance: tutorInstance]
        }
	}
	
	def edit = {
		def tutorInstance = Tutor.get(params.id)
        if (!tutorInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tutor.label', default: 'Tutor'), params.id])}"
            redirect(action: "list")
        }
        else {
            [tutorInstance: tutorInstance]
        }
	}
	
	def create = { }
	
}
