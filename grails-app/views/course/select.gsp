<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'course.label', default: 'Course')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="page">
        <div class="body">
            <h2>Choose a ${entityName}</h2>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form method="post" action="select" class="form-horizontal">
              <div class="form-group ${hasErrors(bean: course, field: 'id', 'error')}">
    			      <label class="control-label col-sm-2" for="courseIdPicker"><g:message code="course.courseId.label" default="Course Code" /></label>
    			      <div class="col-sm-10">
    			        <g:select
                        noSelection="['':'-Choose course-']"
                        name="courseId"
                        from="${courseList}"
                        optionKey="courseId"
                        optionValue="idAndTitle" />
    			      </div>
			        </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <span class="button"><g:actionSubmit action="select" class="save btn btn-primary" value="${message(code: 'default.button.choose.label', default: 'Choose')}" /></span>
                </div>
              </div>
            </g:form>
          </div>
        </div>
    </body>
</html>
