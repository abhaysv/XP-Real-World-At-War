<?php
	include("config.php");
	mysql_connect($mysql_host,$mysql_user,$mysql_password) or die(mysql_error()); 
	mysql_select_db($mysql_dbname) or die(mysql_error()); 
	$id = $_REQUEST['id'];
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<?php 
mysql_select_db($mysql_dbname) or die(mysql_error()); 
$data = mysql_query("SELECT * FROM `settings` WHERE `type` = 1") 
or die(mysql_error());  
while($info = mysql_fetch_array( $data )) 
{ 
	Print "<title>".$info['text'] . "</title>";
}
?>	
<link rel="stylesheet" href="styles.css" type="text/css" />        
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/slider.js"></script>
<script type="text/javascript" src="js/superfish.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
</head>
<body>
<div id="container">
	<div id="header">
		<?php 
		$data = mysql_query("SELECT * FROM `settings` WHERE `type` = 1") 
		or die(mysql_error());  
		while($info = mysql_fetch_array( $data )) 
		{ 
			Print "<h1><strong>".$info['text'] . "</strong></h1>";
		}
		?>
		<?php 
		mysql_select_db($mysql_dbname) or die(mysql_error()); 
		$data = mysql_query("SELECT * FROM `settings` WHERE `type` = 2") 
		or die(mysql_error());  
		while($info = mysql_fetch_array( $data )) 
		{ 
			Print "<h2>".$info['text'] . "</h2>";
		}
		?>		
        <div class="clear"></div>
    </div>
    <div id="nav">
    	<ul class="sf-menu dropdown">
				<?php 
				$data = mysql_query("SELECT * FROM `navigation`") 
				or die(mysql_error());  
				while($info = mysql_fetch_array( $data )) 
				{ 
					Print "<li><a href=".$info['link'] . ">".$info['label'] . "</a></li>";
				}
				$data2 = mysql_query("SELECT * FROM `pages`")
				or die(mysql_error());
				while($info2 = mysql_fetch_array( $data2 ))
				{
					Print "<li><a href=showpage.php?id=".$info2['id'] . ">".$info2['pagename'] . "</a></li>";
				}
				?>
        </ul>
    </div>
    <div id="slides-container">
        <div id="slides">
			<?php
			$data = mysql_query("SELECT * FROM `slide`") 
			or die(mysql_error());  
			while($info = mysql_fetch_array( $data )) 
			{ 
				Print "<div>";
				Print "<h2>".$info['title'] . "</h2>";
				Print "<p>".$info['content'] . "</p>";
				Print "</div>";
			}
			?>
		</div>
        <div class="controls"><span class="jFlowNext"><span>Next</span></span><span class="jFlowPrev"><span>Prev</span></span></div>        
        <div id="myController" class="hidden"><span class="jFlowControl">Slide 1</span><span class="jFlowControl">Slide 1</span><span class="jFlowControl">Slide 1</span></div>
    </div>
    <div id="body" class="has-slider">
		<div id="content">
            <div class="box">
				<?php  
				$data = mysql_query("SELECT * FROM `pages` WHERE `id` = '$id'") 
				or die(mysql_error());  
				$num_rows = mysql_num_rows($data);
				if($num_rows == 0)
				{
					Print "<h3>Error!</h3>";
					Print "<p>Invalid page!</p>";
				}
				while($info = mysql_fetch_array( $data )) 
				{ 
					Print "<h3>".$info['pagename'] . "</h3>";
					Print "<p>".$info['content'] . "</p>";
				}
				?>
			</div>
        </div>
        <div class="sidebar">
            <ul>	
               <li>
                    <h4><span>Navigate</span></h4>
                    <ul class="blocklist">
							<?php 
							$data = mysql_query("SELECT * FROM `navigation`") 
							or die(mysql_error());  
							while($info = mysql_fetch_array( $data )) 
							{ 
								Print "<li><a href=".$info['link'] . ">".$info['label'] . "</a></li>";
							}
							$data2 = mysql_query("SELECT * FROM `pages`")
							or die(mysql_error());
							while($info2 = mysql_fetch_array( $data2 ))
							{
								Print "<li><a href=showpage.php?id=".$info2['id'] . ">".$info2['pagename'] . "</a></li>";
							}
							?>
                    </ul>
                </li>
                <li>
                    <h4><span>About</span></h4>
                    <ul>
                        <li>
                        	<?php 
							$data = mysql_query("SELECT * FROM `settings` WHERE `type` = 4") 
							or die(mysql_error());  
							while($info = mysql_fetch_array( $data )) 
							{ 
								Print "<p>".$info['text'] . "</p>";
							}
							?>	
						</li>
                    </ul>
                </li>
            </ul> 
        </div>
    	<div class="clear"></div>
    </div>
    <div id="footer">
        <div class="footer-content">	
                <span class="sitename">sitename</span>
                 <p class="footer-links">
						<?php 
						$data = mysql_query("SELECT * FROM `navigation`") 
						or die(mysql_error());  
						while($info = mysql_fetch_array( $data )) 
						{ 
							Print "<a href=".$info['link'] . ">".$info['label'] . "</a>";
						}
						$data2 = mysql_query("SELECT * FROM `pages`")
						or die(mysql_error());
						while($info2 = mysql_fetch_array( $data2 ))
						{
							Print "<a href=showpage.php?id=".$info2['id'] . ">".$info2['pagename'] . "</a>";
						}
						?>
    				<a href="#container" class="backtotop">Back to top</a>
               	 </p>
                 <div class="clear"></div>
        </div>
        <div class="footer-bottom">
			<?php 
			$data = mysql_query("SELECT * FROM `settings` WHERE `type` = 3") 
			or die(mysql_error());  
			while($info = mysql_fetch_array( $data )) 
			{ 
				Print "<p>".$info['text'] . "</p>";
			}
			?>
         </div>
    </div>
	<?php
	mysql_close();
	?>
</div>
</body>
</html>
