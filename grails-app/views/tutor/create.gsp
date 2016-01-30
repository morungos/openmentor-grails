<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tutor.label', default: 'Tutor')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="page">
        <div class="body">
            <h2><g:message code="default.create.label" args="[entityName]" /></h2>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form action="save" method="post" class="form-horizontal">
              <div class="control-group ${hasErrors(bean: tutorInstance, field: 'tutorId', 'error')}">
                <label class="control-label" for="tutorId"><g:message code="tutor.tutorId.label" default="Tutor ID " />:</label>
                <div class="controls">
                  <g:textField name="tutorId" class="form-control" value="${tutorInstance?.tutorId}" placeholder="Tutor ID" />
                  <g:hasErrors bean="${tutorInstance}" field="tutorId">
                    <span class="help-inline"><g:renderErrors bean="${tutorInstance}" as="list" field="tutorId"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="control-group ${hasErrors(bean: tutorInstance, field: 'givenName', 'error')}">
                <label class="control-label" for="givenName"><g:message code="tutor.givenName.label" default="Given Name" />:</label>
                <div class="controls">
                  <g:textField name="givenName" class="form-control" value="${tutorInstance?.givenName}" placeholder="Given Name" />
                  <g:hasErrors bean="${tutorInstance}" field="givenName">
                    <span class="help-inline"><g:renderErrors bean="${tutorInstance}" as="list" field="givenName"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="control-group ${hasErrors(bean: tutorInstance, field: 'familyName', 'error')}">
                <label class="control-label" for="familyName"><g:message code="tutor.familyName.label" default="Family Name" />:</label>
                <div class="controls">
                  <g:textField name="familyName" class="form-control" value="${tutorInstance?.familyName}" placeholder="Family Name" />
                  <g:hasErrors bean="${tutorInstance}" field="familyName">
                    <span class="help-inline"><g:renderErrors bean="${tutorInstance}" as="list" field="familyName"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="control-group ${hasErrors(bean: tutorInstance, field: 'courses', 'error')}">
                <label class="control-label" for="courses"><g:message code="tutor.courses.label" default="Courses" />:</label>
                <div class="controls">
                  <g:select id="courses" class="form-control" name="courses" optionKey="id" optionValue="courseId" multiple="${true}" class="chzn-select"
		                    from="${courseList}"
		                    value="${tutorInstance?.courses}"/>
                  <g:hasErrors bean="${tutorInstance}" field="courses">
                    <span class="help-inline"><g:renderErrors bean="${tutorInstance}" as="list" field="courses"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="control-group">
                <div class="controls">
                  <g:submitButton class="save btn btn-primary" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
              </div>
            </g:form>
        </div>
        </div>
        <content tag="postJQuery">
            <g:javascript>
jQuery(document).ready(function() {
  jQuery(".chzn-select").chosen();
});
            </g:javascript>
        </content>
    </body>
</html>
