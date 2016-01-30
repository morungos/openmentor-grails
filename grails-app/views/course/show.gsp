<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'course.label', default: 'Course')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="page">
        <div class="body">
            <h2><g:message code="default.show.label" args="[entityName]" /></h2>
            <g:if test="${flash.message}">
              <div class="alert alert-info">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Note:</strong> ${flash.message}
              </div>
            </g:if>
            <form class="form-horizontal">
              <div class="form-group">
                <label class="control-label col-sm-2" for="courseId"><g:message code="course.courseId.label" default="Course Code" />:</label>
                <div class="col-sm-10">
                  <g:textField name="courseId" value="${courseInstance?.courseId}" disabled="true" />
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-sm-2" for="courseTitle"><g:message code="course.courseTitle.label" default="Course Title" />:</label>
                <div class="col-sm-10">
                  <g:textField name="courseTitle" value="${courseInstance?.courseTitle}" disabled="true" />
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <sec:ifAnyGranted roles="MANAGE_COURSEINFO_ROLE">
                    <g:link class="edit btn btn-primary" name="edit" action="edit" params="${[courseId: courseInstance?.courseId]}">${message(code: 'default.button.edit.label', default: 'Edit')}</g:link>
                  </sec:ifAnyGranted>
                </div>
              </div>
            </form>
        </div>
        </div>
    </body>
</html>
