<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <c:if test="${empty book.title}">
        <title>Add book</title>
    </c:if>
    <c:if test="${!empty book.title}">
        <title>Update book</title>
    </c:if>

    <link rel="stylesheet" href="<c:url value="/styles/addAndEditPage.css"/>" type="text/css"/>
</head>
<body>

<div class="wrapper">
    <div class="inputBlock">
        <c:if test="${empty book.title}">
            <h2>Добавить книгу</h2>
        </c:if>
        <c:if test="${!empty book.title}">
            <h2>Изменить книгу</h2>
        </c:if>

        <c:url var="addAction" value="/save"/>

        <div class="table-block">
            <form:form action="${addAction}" commandName="book">
                <table>
                    <c:if test="${!empty book.title}">
                        <tr>
                            <td>
                                <form:label path="id"> <spring:message text="ID"/></form:label>
                            </td>
                            <td>
                                <form:input path="id" readonly="true" size="8" disabled="true"/>
                                <form:hidden path="id"/>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td><form:label path="title"><spring:message text="Название книги"/></form:label></td>
                        <td><form:input path="title"/></td>
                    </tr>
                    <c:if test="${!empty book.title}">
                        <tr>
                            <td><form:label path="author"><spring:message text="Автор"/></form:label></td>
                            <td>
                                <form:input path="author" readonly="true" disabled="true"/>
                                <form:hidden path="author"/>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${empty book.title}">
                        <tr>
                            <td><form:label path="author"><spring:message text="Автор"/></form:label></td>
                            <td><form:input path="author"/></td>
                        </tr>
                    </c:if>
                    <tr>
                        <td><form:label path="description"><spring:message text="Описание"/></form:label></td>
                        <td><form:textarea path="description" rows="5" cols="30"/></td>
                    </tr>
                    <tr>
                        <td><form:label path="year"><spring:message text="Год написания"/></form:label></td>
                        <td><form:input path="year"/></td>
                    </tr>
                    <tr>
                        <td><form:label path="isbn"><spring:message text="ISBN"/></form:label></td>
                        <td><form:input path="isbn"/></td>
                    </tr>
                    <c:if test="${empty book.title}">
                        <tr>
                            <td><form:label path="readAlready"><spring:message text="Прочитана"/></form:label></td>
                            <td><form:input path="readAlready"/></td>
                        </tr>
                    </c:if>
                </table>

                <div class="submit-btn">
                    <c:if test="${!empty book.title}">
                        <input type="submit" onclick="return updateValidation();"
                               value="<spring:message text="Изменить"/>"/>
                    </c:if>
                    <c:if test="${empty book.title}">
                        <input type="submit" onclick="return addValidation();"
                               value="<spring:message text="Добавить"/>"/>
                    </c:if>
                </div>
            </form:form>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/validators/validators.js" type="text/javascript"></script>

</body>
</html>
