package uk.org.openmentor.controller

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils;

import grails.plugins.springsecurity.Secured;
import uk.org.openmentor.data.Submission;

/**
 * This controller is used to manage the views and actions associated with the
 * history. The precise contents of this history may evolve over time, but it 
 * mainly allows people to track what submissions have been uploaded when, and by
 * whom.
 * 
 * @author morungos
 */

@Secured(['ROLE_OPENMENTOR-USER'])
class HistoryController {
	
	def springSecurityService

    def index() { 
		redirect(action: "list", params: params)
	}
	
	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = params.sort ?: 'dateSubmitted'
		params.order = params.order ?: 'asc'
		params.offset = params.offset ?: '0'
				
		def criteria = Submission.createCriteria()
		
		// For non-administrators, we only show the current user's files.
		def currentUser = springSecurityService.currentUser
		
		def submissionList = criteria.list {
			if (! isAdministrator()) {
				eq("username", currentUser?.username)
			}
			order(params.sort, params.order)
			maxResults(params.max)
			firstResult(Integer.parseInt(params.offset))
		}
		
		def submissionCount = Submission.count()
		
		[submissionInstanceList: submissionList, submissionInstanceTotal: submissionCount]
	}

	private boolean isAdministrator() {
		def authorities = springSecurityService.getAuthentication()?.getAuthorities()
		def roles = SpringSecurityUtils.authoritiesToRoles(authorities)
		return roles.contains('ROLE_OPENMENTOR-ADMIN')

	}
}
