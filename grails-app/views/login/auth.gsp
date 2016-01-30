<head>
  <meta name='layout' content='main' />
  <title>Login</title>
</head>

<body>
	<div id='login'>
		<div class='inner'>
			<g:if test='${flash.message}'>
			  <div class="alert alert-info">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>Note:</strong> ${flash.message}
        </div>
			</g:if>
			<h3>Please Login...</h3>
			<form action='${postUrl}' method='POST' id='loginForm' class='form-horizontal' autocomplete='off'>
			  <div class="form-group">
          <label class="control-label col-sm-2" for="username">Username</label>
          <div class="col-sm-10">
            <input type='text' class='form-control text_' name='j_username' id='username' />
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-sm-2" for="password">Password</label>
          <div class="col-sm-10">
            <input type='password' class='form-control text_' name='j_password' id='password' />
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-primary">Login</button>
          </div>
        </div>
			</form>
		</div>
	</div>
<script type='text/javascript'>
<!--
(function(){
	document.forms['loginForm'].elements['j_username'].focus();
})();
// -->
</script>
</body>
