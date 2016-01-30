
<%@ page import="uk.org.openmentor.courseinfo.Assignment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'submission.label', default: 'Submission')}" />
        <title><g:message code="submission.upload.label" /></title>
    </head>
    <body>
        <div id="page">
        <div class="body">
            <h2><g:message code="submission.upload.label" /></h2>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

			<g:hasErrors bean="${sub}">
            <div class="errors">
                <g:renderErrors bean="${sub}" as="list" />
            </div>
            </g:hasErrors>

            <g:uploadForm action="save" method="post" class="form-horizontal">
              <div class="form-group  ${hasErrors(bean: cmd, field: 'courseId', 'errors')}">
                <label class="control-label col-sm-2" for="courseId"><g:message code="course.courseId.label" default="Course ID" />:</label>
                <div class="col-sm-10">
                  <g:textField name="courseId" class="form-control" value="${courseInstance.courseId}" readonly="readonly" />
                </div>
              </div>
              <div class="form-group ${hasErrors(bean: cmd, field: 'assignmentId', 'error')}">
                <label class="control-label col-sm-2" for="assignment"><g:message code="assignment.label" default="Assignment" />:</label>
                <div class="col-sm-10">
                  <g:select
                    noSelection="['':'-Choose assignment-']"
                    name="assignmentId"
                    from="${assignmentsList}"
                    optionKey="id"
                    value="${cmd?.assignmentId}"
                    optionValue="code" />
                  <g:hasErrors bean="${cmd}" field="assignmentId">
                  <span class="help-inline"><g:renderErrors bean="${cmd}" as="list" field="assignmentId"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="form-group ${hasErrors(bean: cmd, field: 'dataFile', 'error')}">
                <label class="control-label col-sm-2" for="dataFile"><g:message code="assignment.dataFile.label" default="File" />:</label>
                <div class="col-sm-10">
                  <input type="file" class="form-control" name="dataFile" id="file" accept="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document" />
                  <span class="help-block">Word files of all types are supported, maximum size is 16Mb</span>
                  <g:hasErrors bean="${cmd}" field="dataFile">
                  <span class="help-inline"><g:renderErrors bean="${cmd}" as="list" field="dataFile"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="form-group ${hasErrors(bean: cmd, field: 'grade', 'error')}">
                <label class="control-label col-sm-2" for="grade"><g:message code="assignment.grade.label" default="Marks category given" />:</label>
                <div class="col-sm-10">
                  <g:select
                    noSelection="['':'-Choose grade-']"
                    class="form-control"
                    name="grade"
                    value="${cmd?.grade}"
                    from="${grades}" />
                  <g:hasErrors bean="${cmd}" field="grade">
                  <span class="help-inline"><g:renderErrors bean="${cmd}" as="list" field="grade"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="form-group ${hasErrors(bean: cmd, field: 'tutorIds', 'error')}">
                <label class="control-label col-sm-2" for="tutorIds"><g:message code="default.tutor.label" default="Tutor" />:</label>
                <div class="col-sm-10">
                  <g:select
                    noSelection="['':'-Choose tutor-']"
                    name="tutorIds"
                    class="form-control"
                    from="${courseInstance.tutors}"
                    value="${cmd?.tutorIds}"
                    optionKey="tutorId"
                    optionValue="idAndName" />
                  <g:hasErrors bean="${cmd}" field="tutorIds">
                  <span class="help-inline"><g:renderErrors bean="${cmd}" as="list" field="tutorIds"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="form-group ${hasErrors(bean: cmd, field: 'studentIds', 'error')}">
                <label class="control-label col-sm-2" for="studentIds"><g:message code="default.student.label" default="Student" />:</label>
                <div class="col-sm-10">
                  <g:select
	                 noSelection="['':'-Choose student-']"
	                 name="studentIds"
                   class="form-control"
	                 from="${courseInstance.students}"
	                 value="${cmd?.studentIds}"
	                 optionKey="studentId"
	                 optionValue="idAndName" />
                  <g:hasErrors bean="${cmd}" field="studentIds">
                  <span class="help-inline"><g:renderErrors bean="${cmd}" as="list" field="studentIds"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <g:submitButton class="save btn btn-primary" name="upload" value="${message(code: 'default.button.upload.label', default: 'Upload')}" />
                </div>
              </div>
            </g:uploadForm>
		</div>
		</div>
	</body>
</html>
