<!DOCTYPE html>
<html lang="zh-TW">
	<head>
		<meta http-equiv="refresh" content="3" >
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<title>gateway資訊台</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons"rel="stylesheet">
		<style>
			body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,textarea,p,blockquote,th,td{margin:0;padding:0;}table{border-collapse:collapse;border-spacing:0;}fieldset,img{border:0;}address,caption,cite,code,dfn,em,strong,th,var{font-style:normal;font-weight:normal;}li{list-style:none;}caption,th{text-align:left;}h1,h2,h3,h4,h5,h6{font-size:100%;font-weight:norma;}q:before,q:after{content:;}abbr,acronym{border:0;font-variant:normal;}sup{vertical-align:text-top;}sub{vertical-align:text-bottom;}input,textarea,select{font-family:inherit;font-size:100%;font-weight:inherit;}legend{color:#000;}
			body{color:#333;font-family:Arial, 'Helvetica Neue', Helvetica, 'Microsoft JhengHei', '微軟正黑體', sans-serif;}
			.wrap{display:table;margin:0 auto;}
			.path{width:100%;height:100px;padding:20px 0 10px;font-size:30px;text-align:center;display:table-cell;vertical-align:middle;}
			.location{margin-left:10px;color:#009688;font-size:45px;font-weight:bold;vertical-align:middle;position:relative;top:-2px;}
			span.disappear{margin:0 auto;color:#ff6600;font-size:50px;display:none;}
			span.disappear .material-icons{line-height:0;font-size:50px;vertical-align:middle;position:relative;top:-3px;}
			span.disappear.show{display:block;-webkit-animation:flash .5s 1s infinite both alternate;
				-moz-animation:flash .5s 1s infinite both alternate;
				-ms-animation:flash .5s 1s infinite both alternate;
				-o-animation:flash .5s 1s infinite both alternate;
				animation:flash .5s 1s infinite both alternate;}
			@-webkit-keyframes flash {from{opacity:1;}to{opacity:0;}}
			@-moz-keyframes flash {from{opacity:1;}to{opacity:0;}}
			@-ms-keyframes flash {from{opacity:1;}to{opacity:0;}}
			@-o-keyframes flash {from{opacity:1;}to{opacity:0;}}
			@keyframes flash {from{opacity:1;}to{opacity:0;}}
			.node{width:80%;margin:0 auto;padding-top:20px;border-top:1px solid #ccc;text-align:center;}
			.node > *{display:inline-block;}
			.node dt{background:#43A047;width:50px;height:30px;margin:0 20px;padding:10px 0;border-radius:100%;line-height:100%;color:#fff;font-size:15px;vertical-align:middle;}
			.node .lot-pad{height:20px;padding:18px 0 12px;}
			.node dd{width:90px;margin-left:-100px;text-align:center;position:relative;top:50px;left:6px;}
			.node dt.disappear{background:#ccc;}
			.node dd.disappear{color:#ccc;}
		</style>
	</head>
	<body>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.0/jquery.js"></script>
		<script>
		$(function(){
			// $(".location").text("大會議室");
			//$(".node").find("dt").eq(3).toggleClass("disappear");
		})

		</script>

		<!-- status 會有兩種不同的訊息 正常接收訊息：正 已偏離出現時：最後
			 使用者偏離時 disappear要加上show
		-->
		<div class="wrap">
			<p class="path"><i class="material-icons">directions_walk</i>使用者<span class="status">正</span>在<span class="location">
				<!-- tpl 裡 % 指的是執行這行 inline python code 而 <% %> 指的是 code block -->
				% if location:
					{{location}}
				% else:
					UX
				% end
			</span><span class="disappear"><i class="material-icons">warning</i>偏離</span></p>
		</div>
		<dl class="node">
			% for beacon in passData:
				% if beacon[2] < 1:
					<dt class="lot-pad disappear">{{deviceName[beacon[0]]}}</dd>
					<dd class="disappear">無法偵測</dd>
				% else:
					<dt class="lot-pad">{{deviceName[beacon[0]]}}</dd>
					<dd>{{beacon[3]}}</dd>
				% end
			% end
			<!-- <dt>中會<br>議室</dt>
			<dd>550m</dd> -->
			<!-- node壞掉偵測不到時 dt跟dd都要加上disappear -->
			<!-- <dt class="lot-pad disappear">UX</dt>
			<dd class="disappear">150km</dd>
			<dt class="lot-pad">IT</dt>
			<dd>150km</dd>
			<dt>大會<br>議室</dt>
			<dd>150km</dd> -->
		</dl>
	</body>
</html>
