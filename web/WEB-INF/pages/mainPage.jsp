<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Book Page</title>
    <link rel="stylesheet" href="<c:url value="/styles/mainPage.css"/>" type="text/css"/>
</head>
<body>
<br/>
<br/>

<div class="wrapper">
    <h1 align="center">Список книг</h1>
    <div class="upper-menu">
        <a id="add" href="add">Добавить книгу</a>
        <form id="search" action="search">
            <input id="input-search" type="text" name="searchName" placeholder="Поиск по названию...">
            <input id="btn-search" type='submit' value='Поиск'/>
        </form>
    </div>

    <div class="table-list">
        <c:if test="${empty listBooks}"><label id="found">Не найдено ни одной книги</label></c:if>

        <c:if test="${!empty listBooks}">
            <table class="tg">
                <tr>
                    <th>№</th>
                    <th>Название</th>
                    <th>Автор</th>
                    <th>Год</th>
                    <th>Описание</th>
                    <th>ISBN</th>
                    <th>Прочтена</th>
                    <th>Прочитать</th>
                    <th>Изменить</th>
                    <th>Удалить</th>
                </tr>
                <c:forEach items="${listBooks}" var="book">
                    <tr>
                        <td>${page == null ? listBooks.indexOf(book) + 1 : listBooks.indexOf(book) + 1 + (page-1)*10}</td>
                        <td>${book.title}</td>
                        <td>${book.author}</td>
                        <td>${book.year}</td>
                        <td>${book.description}</td>
                        <td width="120">${book.isbn}</td>
                        <td>${book.readAlready ? "Да" : "Нет"}</td>
                        <c:if test="${!book.readAlready}">
                            <td>
                                <a href="read?id=<c:out value='${book.id}'/>&page=<c:out value='${page}'/>">Прочитать</a>
                            </td>
                        </c:if>
                        <c:if test="${book.readAlready}">
                            <td><a style="pointer-events: none; cursor: default; visibility: hidden;" href=""></a></td>
                        </c:if>
                        <td><a href="edit?id=<c:out value='${book.id}'/>">Изменить</a></td>
                        <td><a href="remove?id=<c:out value='${book.id}'/>&page=<c:out value='${page}'/>">Удалить</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>
    <div align="center" class="panel-footer">
        <c:url value="/" var="prev">
            <c:param name="page" value="${page-1}"/>
        </c:url>
        <c:if test="${page > 1}">
            <a href="<c:out value="${prev}" />" class="pn prev">Пред</a>
        </c:if>

        <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
            <c:choose>
                <c:when test="${page == i.index}">
                    <span>${i.index}</span>
                </c:when>
                <c:otherwise>
                    <c:url value="/" var="url">
                        <c:param name="page" value="${i.index}"/>
                    </c:url>
                    <a href='<c:out value="${url}" />'>${i.index}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:url value="/" var="next">
            <c:param name="page" value="${page + 1}"/>
        </c:url>
        <c:if test="${page + 1 <= maxPages}">
            <a href='<c:out value="${next}" />' class="pn next">След</a>
        </c:if>
    </div>
</div>
</body>
</html>
