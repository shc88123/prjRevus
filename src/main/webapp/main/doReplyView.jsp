<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.BeanBoard"%>
<%@ page import="board.DaoBoard"%>
<%@ page
	import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@ page import="java.util.List"%>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("classpath:spring-member.xml");
	List<BeanBoard> list = ctx.getBean("daoBoard", board.DaoBoard.class).selectReplyById(num);
	if (list.isEmpty()) {
		out.print("<div>댓글이 없습니다.</div>");
	} else {
		for (int i = 0; i < list.size(); i++) {
			String n = list.get(i).getName();
			String c = list.get(i).getPosting();
			out.print("<div><input type='text' value='" + n + ": " + c + "' readonly /></div>");
		}
	}
	ctx.close();
%>