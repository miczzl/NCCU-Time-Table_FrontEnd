<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NCCU TIME TABLE</title>
<link rel="stylesheet" type="text/css" href="css/main.css" />
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
if(${conflict}) {
	alert("衝堂");
}
	$(function() {
		
		//About us
		$('#about').click(function() {
			alert(' ----NCCU Time Table---- \n Hi! We are group 1 from DB Management Systems.');
		});
		//追蹤清單--顯示/隱藏選單
		$('.followTable').on('click', 'td', function() {
			if($('>.c-menu', this).is(':visible')) {
				$('>.c-menu', this).hide();
			} else {
				$('.c-menu').hide();
				$('>.c-menu', this).show();
			}
		});
		
		/**
		*	連結Servlet
		*/
		// search(未修課程--點擊加入搜尋欄並搜尋)
		$('.bottomTable').on('click', 'td', function() {
			$("#text-search").val($(this).html());
			document.forms["search"].submit();
		});
		// addFollowList(搜尋結果--加入追蹤清單)
		$('.searchTable').on('click', 'td', function() {
			$('#text-add-follow').val($(this).html());
			alert("加入追蹤清單");
			document.forms["addFollowlist"].submit();
		});
		// deleteFollowList(追蹤清單--取消追蹤)
		$('.followTable').on('click', '#c-del', function() {
			alert("取消追蹤");
			$("#text-delete-follow").val($(this).closest('td').children('label').html());
			document.forms["deleteFollowlist"].submit();
		});
		// addSchedule(追蹤清單--加入課表)
		$('.followTable').on('click', '#c-add', function() {
			alert("加入課表");
			$("#text-add-schedule").val($(this).closest('td').children('label').html());
			document.forms["addSchedule"].submit();
		});
		// deleteSchedule(課表--刪除課程)
		$('.scheduleTable').on('click', 'td', function() {
			alert("移除課程");
			$("#text-delete-schedule").val($('>label', this).html());
			document.forms["deleteSchedule"].submit();
		});
	});
</script>
</head>
<body>
	<!-- Header -->
	<div class="header">
		<div><img src='img/schedule.png'>NCCU Time Table</div>
		<div id='about'>About Us</div>
		<div><a href='logout'>Log Out</a></div>
		<div>Welcome! ${student.getName()}</div>
	</div><!-- Header -->
	
	<!-- Schedule -->
	<div class="schedule">
		<!-- table: scheduleTable -->
		<table class="scheduleTable">
			<thead><tr>
					<th scope="col"></th>
					<th scope="col">Mon</th>
					<th scope="col">Tue</th>
					<th scope="col">Wed</th>
					<th scope="col">Thu</th>
					<th scope="col">Fri</th>
			</tr></thead>
			<c:forEach var="row" items="${student.getScheduleTable()}">
				<tr>
					<c:forEach var="col" items="${row}">
						<c:if test="${col.getDay().equals(\"Sun\")}">
							<th>${col.getHour()}</th>
						</c:if>
						<c:if test="${!col.getDay().equals(\"Sun\")}">
							<td>
								<c:if test="${!col.getId().equals(\"\")}">${col.getCourse_name()}</c:if>
								<label style="display: none">${col.getId()}</label>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
		<!-- form: deleteSchedule -->
		<form name='deleteSchedule' action='deleteSchedule' method='post'>
			<input type='text' id='text-delete-schedule' name="delete_schedule" value='${delete_schedule}' style="display: none"/>
		</form>
	</div><!-- Schedule -->
	
	<!-- 側邊欄 -->
	<div class="verticle">
	
		<!-- 搜尋欄 -->
		<div class="searchField">
			<!-- form: search -->
			<form name='search' action='search' method='post'>
				<input type='text' id='text-search' placeholder='Search...' name="keyword" value='${keyword}'/>
			</form>
		</div><!-- 搜尋欄 -->	
		
		<!-- 搜尋結果 -->
		<div class="searchResult">
			<!-- table: searchTable -->
			<table class="searchTable">
				<c:forEach var="section" items="${searches}">
					<tr><td id='search_result'><c:out value="${section.toString()}"/></td></tr>
				</c:forEach>
			</table>
			<!-- form: addFollowlist -->
			<form name='addFollowlist' action='addFollowlist' method='post'>
				<input type='text' id='text-add-follow' name="add_follow" value='${add_follow}' style="display: none"/>
			</form>
		</div><!-- 搜尋結果 -->
		
		<!-- 追蹤清單 -->
		<div class="title">追蹤清單</div>
		<div class="followList">
			<!-- table: followTable -->
			<table class="followTable">
				<c:forEach var="section" items="${student.getFollow_List()}">
					<tr><td>
						<label><c:out value="${section.toString()}"/></label><br>
						<label class="detail"><c:out value="${section.detail()}"/></label>
						<div class="c-menu" style="display: none">
							<p class="c-menu-li" id="c-add">加入課表</p>
							<p class="c-menu-li"><a href="${section.getUrl()}">連結大綱</a></p>
							<p class="c-menu-li" id="c-del">取消追蹤</p>
						</div>
					</td></tr>
				</c:forEach>
			</table>
			<!-- form: deleteFollowlist -->
			<form name='deleteFollowlist' action='deleteFollowlist' method='post'>
				<input type='text' id='text-delete-follow' name="delete_follow" value='${delete_follow}' style="display: none"/>
			</form>
			<!-- form: addSchedule -->
			<form name='addSchedule' action='addSchedule' method='post'>
				<input type='text' id='text-add-schedule' name="add_schedule" value='${add_schedule}' style="display: none"/>
			</form>
		</div><!-- 追蹤清單 -->
		
	</div><!-- 側邊欄 -->
	
	<!-- Bottom -->
	<div class="bottom">
	
		<!-- 未修課程 -->
		<div class="title">未修課程</div>
		<div class="unSelectedItem">
			<!-- 本系必修 -->
			<div class="botit t1">本系必修</div>
			<div>
				<table class="table bottomTable">
					<c:forEach var="course" items="${student.getUntakenMajor()}">
						<tr><td><c:out value="${course}"/></td></tr>
					</c:forEach>
				</table>
			</div>
			<!-- 雙主修 -->
			<div class="botit t2">雙主修</div>
			<div>
				<table class="table bottomTable">
					<c:forEach var="course" items="${student.getUntakenDoubleMajor()}">
						<tr><td><c:out value="${course}"/></td></tr>
					</c:forEach>
				</table>
			</div>
			<!-- 輔系 -->
			<div class="botit t3">輔系</div>
			<div>
				<table class="table bottomTable">
					<c:forEach var="course" items="${student.getUntakenMinor()}">
						<tr><td><c:out value="${course}"/></td></tr>
					</c:forEach>
				</table>
			</div>
		</div><!-- 未修課程 -->
	
	</div><!-- Bottom -->

</body>
</html>