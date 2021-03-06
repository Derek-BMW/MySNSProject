<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.include file="header.jsp" />
<div class="mainarea">
	<div class="maininner">
		<div class="tabs_header">
			<ul class="tabs">
				<li${actives.view}><a href="admincp.jsp?ac=cron"><span>浏览全部</span></a></li>
				<li class="null"><a href="admincp.jsp?ac=cron&op=add">添加新计划任务</a></li>
			</ul>
		</div>
		<form method="post" action="admincp.jsp?ac=cron&cronid=${cronid}">
			<input type="hidden" name="formhash" value="${jch:formHash(sGlobal,sConfig,true)}" />
			<c:choose>
				<c:when test="${op == 'edit' || op == 'add'}">
					<div class="bdrcontent">
						<table cellspacing="0" cellpadding="0" class="formtable">
							<tr>
								<th style="width: 12em;">任务名</th>
								<td><input size="25" name="name" value="${thevalue.name}" type="text"></td>
							</tr>
							<tr>
								<th>任务脚本</th>
								<td><input size="25" name="filename" value="${thevalue.filename}" type="text"><br>不能包含路径，程序脚本必须存放于 ./source/cron/ 目录中</td>
							</tr>
							<tr>
								<th>有效性</th>
								<td>
									<input type="radio" name="available" value="1"${availables["1"]}>有效
									<input type="radio" name="available" value="0"${availables["0"]}>无效
								</td>
							</tr>
							<tr>
								<th>星期</th>
								<td>
									<select name="weekday">
										<option value="-1">*</option>
										<option value="0"${weekdays["0"]}>星期日</option>
										<option value="1"${weekdays["1"]}>星期一</option>
										<option value="2"${weekdays["2"]}>星期二</option>
										<option value="3"${weekdays["3"]}>星期三</option>
										<option value="4"${weekdays["4"]}>星期四</option>
										<option value="5"${weekdays["5"]}>星期五</option>
										<option value="6"${weekdays["6"]}>星期六</option>
									</select>
									<br>本设置会覆盖下面的“日”设定
								</td>
							</tr>
							<tr>
								<th>日</th>
								<td>
									<select name="day">
										<option value="-1">*</option>
										${daystr}
									</select>
								</td>
							</tr>
							<tr>
								<th>小时</th>
								<td>
									<select name="hour">
										<option value="-1">*</option>
										${hourstr}
									</select>
								</td>
							</tr>
							<tr>
								<th>分钟</th>
								<td>${minuteselect}</td>
							</tr>
						</table>
					</div>
					<div class="footactions"><input type="submit" name="cronsubmit" value="提交" class="submit"></div>
				</c:when>
				<c:otherwise>
					<div class="bdrcontent">
						<table cellspacing="0" cellpadding="0" class="formtable">
							<tr>
								<th>任务名</th>
								<th>上次执行/下次执行</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${list}" var="cron">
								<tr>
									<td><b>${cron.name}</b><br />${cron.filename}</td>
									<td>${cron.lastrun}<br>${cron.nextrun}</td>
									<td>
										<a href="admincp.jsp?ac=cron&op=edit&cronid=${cron.cronid }">编辑</a>
										<c:if test="${cron.available > 0}">&nbsp;|&nbsp;<a href="admincp.jsp?ac=cron&op=run&cronid=${cron.cronid }">执行</a></c:if>
										<c:if test="${cron.type != 'system'}">&nbsp;|&nbsp;<a href="admincp.jsp?ac=cron&op=delete&cronid=${cron.cronid }">删除</a></c:if>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</c:otherwise>
			</c:choose>
		</form>
	</div>
</div>
<div class="side">
	<jsp:directive.include file="side.jsp" />
</div>
<jsp:directive.include file="footer.jsp" />