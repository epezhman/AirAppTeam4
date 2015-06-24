<%@tag description="Overall Page template" pageEncoding="UTF-8"%>
<%@attribute name="body" fragment="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Air App</title>

<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link href="./resources/css/custom.css" rel="stylesheet">

<script src="./resources/js/jquery-1.11.3.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>

</head>

<body>
	<nav class="navbar navbar-fixed-top navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="./home.html">Air App</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="./home.html">Home</a></li>
					<li><a href="./sample">Sample</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container main">
		<div class="row">
			<div class="col-md-12" id="body">
				<jsp:invoke fragment="body" />
			</div>
		</div>

	</div>
</body>
</html>
