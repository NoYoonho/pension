<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<style>
#section {
	width:1100px;
	height:500px;
	margin:auto;
	margin-top:20px;
}
</style>
<script>
function addform() {
	var size = document.getElementsByClassName("up").length;
 
	if(size < 10) {
		var out = document.getElementById("outer");
		out.innerHTML = out.innerHTML+ "<p class='up'> <input type='file' name='fname"+(size+1)+"'> </p>";
	}
}
function delform() {
	var size = document.getElementsByClassName("up").length;
	if(size != 1) {
		var out = document.getElementById("outer");
		document.getElementsByClassName("up")[size-1].remove();
	}
}
  function vieww()
  {
	  document.getElementById("ss").innerText=document.getElementsByTagName("body")[0].innerHTML;
  }
</script>
<div id="ss"></div>
<input type="button" onclick="vieww()" value="click">
<div id="section">
	<table width="600" align="center">
		<form method="post" action="twrite_ok.jsp" enctype="multipart/form-data">
			<caption><h3>후기 게시글 작성</h3></caption>	
				<tr>
					<td>제목</td>
					<td><input type="text" name="title"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="content"></textarea></td>
				</tr>
				<tr>
					<td rowspan="2">사진</td>
					<td>
						<input type="button" value="사진추가" onclick="addform()">
						<input type="button" value="삭제" onclick="delform()">
					</td>
				</tr>
				<tr>
					<td id="outer"><p class="up"><input type="file" name="fname1"></p>
					 
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="저장">
					</td>
				</tr>
		
	</table>
	</form>
</div>

<%@ include file="../bottom.jsp" %>