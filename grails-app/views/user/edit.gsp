<%@ page import="uk.org.openmentor.auth.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <h2><g:message code="default.edit.label" args="[entityName]" /> ${fieldValue(bean: userInstance, field: "username")}</h2>
            <g:if test="${flash.message}">
              <div class="alert alert-info">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Note:</strong> ${flash.message}
                <g:hasErrors bean="${userInstance}">
                  <div class="errors">
                    <g:renderErrors bean="${userInstance}" as="list" />
                  </div>
                </g:hasErrors>
              </div>
            </g:if>
            <g:form action="update" method="post" class="form-horizontal">
              <g:hiddenField name="id" value="${userInstance.id}" />
              <g:hiddenField name="version" value="${userInstance.version}" />
	            <div class="form-group ${hasErrors(bean: userInstance, field: 'username', 'error')}">
                <label class="control-label col-sm-2" for="username"><g:message code="user.username.label" default="Username" />:</label>
                <div class="col-sm-10">
                  <g:textField name="username" class="form-control" value="${userInstance.username}" placeholder="Username" />
                  <g:hasErrors bean="${userInstance}" field="username">
                    <span class="help-inline"><g:renderErrors bean="${userInstance}" as="list" field="username"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="form-group ${hasErrors(bean: userInstance, field: 'password', 'error')}">
                <label class="control-label col-sm-2" for="password"><g:message code="user.password.label" default="Password" />:</label>
                <div class="col-sm-10">
                  <g:passwordField name="password" class="form-control" value="" placeholder="Password" />
                  <g:hasErrors bean="${userInstance}" field="password">
                    <span class="help-inline"><g:renderErrors bean="${userInstance}" as="list" field="password"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <div class="control-group ${hasErrors(bean: userInstance, field: 'confirm', 'error')}">
                <label class="control-label col-sm-2" for="confirm"><g:message code="user.confirm.label" default="Verify" />:</label>
                <div class="col-sm-10">
                  <g:passwordField name="confirm" class="form-control" value="" placeholder="Verify" />
                  <g:hasErrors bean="${userInstance}" field="confirm">
                    <span class="help-inline"><g:renderErrors bean="${userInstance}" as="list" field="confirm"/></span>
                  </g:hasErrors>
                </div>
              </div>
              <sec:ifAnyGranted roles="ROLE_OPENMENTOR-ADMIN">
              <div class="form-group">
                <label class="control-label col-sm-2"><g:message code="user.roles.label" default="Roles" />:</label>
                <div class="col-sm-10">
                  <g:each in="${availableRoles}" status="i" var="availableRole">
                    <label class="checkbox">
                      <g:checkBox id="${'role_' + availableRole}"
                        name="${'role_' + availableRole}"
                        class="form-control"
                        value="${availableRole}"
                        disabled="${availableRole == 'ROLE_OPENMENTOR-USER'}"
                        checked="${userRoles.contains(availableRole)}" />
                      ${availableRole}
                      <g:if test="${availableRole == 'ROLE_OPENMENTOR-USER'}"><g:hiddenField name="role_0" value="${availableRole}" /></g:if>
                    </label>
                  </g:each>
                </div>
              </div>
              </sec:ifAnyGranted>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <g:submitButton class="save btn btn-primary" name="save" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                </div>
              </div>
	         </g:form>
        </div>
    </body>
</html>
