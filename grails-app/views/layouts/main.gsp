<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title><g:layoutTitle default="OpenMentor" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link rel="stylesheet" href="${resource(dir:'css/jqueryui',file:'jquery-ui-1.9.2.custom.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.css')}">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }
    </style>
    <link rel="stylesheet" href="${resource(dir:'css',file:'chosen.css')}">
    <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}">
    <g:javascript src='libs/jquery-1.9.1.js'/>
    <g:javascript src='libs/bootstrap.js'/>
    <g:javascript src='libs/bootstrap.file-input.js'/>
    <g:javascript src='libs/excanvas.min.js'/>
    <g:javascript src='libs/raphael.js'/>
    <g:javascript src='libs/chosen.jquery.min.js'/>
    <g:javascript src='jquery.bulletcharts.js'/>
    <g:layoutHead />

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                  aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="${resource(dir:'/',file:'')}">OpenMentor</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="${resource(dir:'/',file:'')}">Home</a></li>
            <li><g:link action="index" controller="help">About</g:link></li>
            <li><g:link action="contact" controller="help">Contact</g:link></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <sec:ifLoggedIn>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">
                  Logged in as <sec:username/> <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                  <li><g:link controller='logout' class='navbar-link'>Logout</g:link></li>
                </ul>
              </li>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
              <li><g:link controller='login' class='navbar-link'>Log in</g:link></li>
            </sec:ifNotLoggedIn>
          </ul>
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div class="col-md-3">
          <div class="well sidebar-nav">
            <ul class="nav nav-list">
              <g:if test="${! session.current_course}">
                <li>
                  <g:link class="active" action="select" controller="course">Choose course</g:link>
                </li>
                </g:if>
                <g:else>
                <li>
                  <g:link action="select" controller="course">Using course: ${session.current_course} (Change)</g:link>
                </li>
                <li>
                  <g:link action="index" controller="assignment">Assignments</g:link>
                </li>
                <li>
                  <g:link action="upload" controller="submission">Upload submissions</g:link>
                </li>
                <li>
                  <g:link action="index" controller="report">View reports</g:link>
                </li>
              </g:else>
              <sec:ifAnyGranted roles="ROLE_OPENMENTOR-USER">
                <li class="divider"></li>
                <li>
                  <g:link action="index" controller="course">Courses</g:link>
                </li>
                <li>
                  <g:link action="index" controller="student">Students</g:link>
                </li>
                <li>
                  <g:link action="index" controller="tutor">Tutors</g:link>
                </li>
              </sec:ifAnyGranted>
              <sec:ifLoggedIn>
                <li class="divider"></li>
              <sec:ifAnyGranted roles="ROLE_OPENMENTOR-ADMIN">
                <li>
                  <g:link action="index" controller="user">Users</g:link>
                </li>
              </sec:ifAnyGranted>
                <li>
                  <g:link action="index" controller="history">History</g:link>
                </li>
              </sec:ifLoggedIn>
              </ul>
          </div><!--/.well -->
        </div><!--/span-->
        <div class="col-md-9">
          <g:layoutBody />
        </div><!--/span-->
      </div><!--/row-->

    </div><!--/.fluid-container-->

    <section id="footer" class="scroll-section footer-section">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12">
                  <hr>
                </div>
            </div>
            <div>
                <div class="col-sm-4">
                  <h5>turalt</h5>
                  <p>
                    Copyright &copy; 2015. All rights reserved<br>
                    <a href="/privacy">Privacy</a>
                  </p>
                </div>
                <div class="col-sm-4">
                  <h5>Products and services</h5>
                  <p>
                    <a anchor-scroll-to="home#tools" href="#tools">Tools</a><br>
                    <a anchor-scroll-to="home#training" href="#training">Training</a>
                  </p>
                </div>
                <div class="col-sm-4">
                  <h5>Contact us</h5>
                  <p>
                    Email: <a href="mailto:info@turalt.com">info@turalt.com</a><br>
                    Tel: <a href="tel:+14165228287">416-522-8287</a>
                  </p>
                </div>
            </div>
        </div>
    </section>

    <div id="jqdialog"></div>
    <div id="postJQuery">
      <g:pageProperty name="page.postJQuery" />
    </div>
  </body>
</html>
