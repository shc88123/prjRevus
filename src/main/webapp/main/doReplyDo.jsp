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
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	if (content.equals("") || content == null)
		content = "좋아요";
	GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("classpath:spring-member.xml");
	BeanBoard re = new BeanBoard();
	re.setEmail(email);
	re.setName(name);
	re.setPosting(content);
	re.setRe_ref(num);
	int result = ctx.getBean("daoBoard", board.DaoBoard.class).boardReply(re);
	if (result > 0) {
		List<BeanBoard> list = ctx.getBean("daoBoard", board.DaoBoard.class).selectReplyById(num);
		for (int i = 0; i < list.size(); i++) {
			String n = list.get(i).getName();
			String c = list.get(i).getPosting();
			out.print("<div><input type='text' value='" + n + ": " + c + "' readonly /></div>");
		}
	}
	ctx.close();
%>