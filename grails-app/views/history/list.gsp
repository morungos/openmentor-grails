<%@ page import="uk.org.openmentor.data.Submission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'submission.label', default: 'Submission')}" />
        <title><g:message code="default.history.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="page">
        <div class="body">
            <h2><g:message code="default.history.label" args="[entityName]" /></h2>
            <g:if test="${flash.message}">
              <div class="alert alert-info">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Note:</strong> ${flash.message}
              </div>
            </g:if>
            <div class="buttons">
            </div>
            <div class="list">
                <table class="table table-striped">
                    <thead>
                        <tr>         
                            <g:sortableColumn property="dateSubmitted" title="${message(code: 'submission.date.label', default: 'Date submitted')}" />
                            <g:sortableColumn property="filename" title="${message(code: 'submission.filename.label', default: 'File')}" />
                            <g:sortableColumn property="username" title="${message(code: 'submission.username.label', default: 'Username')}" />
						</tr>
                    </thead>
                    <tbody>
                    <g:each in="${submissionInstanceList}" status="i" var="submissionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link controller="submission" action="show" id="${fieldValue(bean: submissionInstance, field: 'id')}">${fieldValue(bean: submissionInstance, field: "dateSubmitted")}</g:link></td>
                            <td>${fieldValue(bean: submissionInstance, field: "filename")}</td>
                            <td>${fieldValue(bean: submissionInstance, field: "username")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${submissionInstanceTotal}"/>
            </div>
        </div>
        </div>
    </body>
</html>
