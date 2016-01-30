<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'assignment.label', default: 'Assignment')}" />
        <title><g:message code="assignment.edit.label" args="${[courseInstance.courseId]}" /></title>
    </head>
    <body>
        <div id="page">
        <div class="body">
            <h2><g:message code="assignment.edit.label" args="${[courseInstance.courseId]}" /></h2>
            <g:if test="${flash.message}">
              <div class="alert alert-info">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Note:</strong> ${flash.message}
              </div>
            </g:if>
            <g:form action="update" method="post" class="form-horizontal">
              <g:hiddenField name="id" value="${assignmentInstance.code}" />
              <g:hiddenField name="version" value="${assignmentInstance?.version}" />
              <div class="form-group">
                <label class="control-label col-sm-2" for="courseId"><g:message code="assignment.courseId.label" default="Course ID" />:</label>
                <div class="col-sm-10 ${hasErrors(bean: assignmentInstance, field: 'course', 'errors')}">
                  <g:textField name="courseId" value="${assignmentInstance?.course?.courseId}" readonly="readonly" />
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-sm-2" for="code"><g:message code="assignment.code.label" default="Code" />:</label>
                <div class="col-sm-10 ${hasErrors(bean: assignmentInstance, field: 'code', 'errors')}">
                  <g:hasErrors bean="${assignmentInstance}" field="code">
                    <g:renderErrors bean="${assignmentInstance}" as="list" field="code"/>
                  </g:hasErrors>
                  <g:textField name="code" class="form-control" value="${assignmentInstance?.code}" placeholder="Code" />
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-sm-2" for="title"><g:message code="assignment.title.label" default="Title" />:</label>
                <div class="col-sm-10 ${hasErrors(bean: assignmentInstance, field: 'title', 'errors')}">
                  <g:hasErrors bean="${assignmentInstance}" field="title">
                    <g:renderErrors bean="${assignmentInstance}" as="list" field="title"/>
                  </g:hasErrors>
                  <g:textField name="title" class="form-control" value="${assignmentInstance?.title}" placeholder="Title" />
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <g:submitButton class="save btn btn-primary" name="save" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                </div>
              </div>
            </g:form>
        </div>
        </div>
    </body>
</html>
