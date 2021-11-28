<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:ordertemplate>
<style>
body {
  font-family: Arial, Helvetica, sans-serif;
}

.flip-card {
  background-color: transparent;
  width: 290px;
  height: 290px;
  perspective: 1000px;
}

.flip-card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  text-align: center;
  transition: transform 0.6s;
  transform-style: preserve-3d;
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
}

.flip-card:hover .flip-card-inner {
  transform: rotateY(180deg);
}

.flip-card-front, .flip-card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  -webkit-backface-visibility: hidden;
  backface-visibility: hidden;
}

.flip-card-front {
  background-color: #bbb;
  color: black;
}

.flip-card-back {
  background-color: #61d124;
  color: black;
  transform: rotateY(180deg);
}
.sidenav{
	width: 250;
	top: 82;
}
#open{
	display: none;
}
#close{
	display: none;
}
</style>
<div class="container" style="padding-left: 250px">
	<h2>Our bestsellers 🤩😋🍿🤩</h2><hr>
	<div class="row">
	<div class="flip-card">
  <div class="flip-card-inner">
    <div class="flip-card-front">
      <img src="https://i.ibb.co/zrhrp98/strawberry-rabdi.jpg" alt="Avatar" style="width:290px;height:300px;">
    </div>
    <div class="flip-card-back">
      <h1>Strawberry Rabdi</h1><hr>
      <p>Strawberries are almost everyone’s favourite.<br>What will it taste like if it’s flavour is added to rabdi 🍸🍸</p> 
    </div>
  </div>
</div>
<div class="flip-card">
  <div class="flip-card-inner">
    <div class="flip-card-front">
      <img src="https://i.ibb.co/F6fxdhS/kala-jamun.gif" alt="Avatar" style="width:290px;height:300px;">
    </div>
    <div class="flip-card-back">
      <h1>Kala Jamun</h1><hr>
      <p>Gulab jamun is a milk-solid-based sweet, originating in India and a type of mithai 😋😋</p> 
    </div>
  </div>
</div>
<div class="flip-card">
  <div class="flip-card-inner">
    <div class="flip-card-front">
      <img src="https://i.ibb.co/gJQmJVh/kaju-katli.jpg" alt="Avatar" style="width:290px;height:300px;">
    </div>
    <div class="flip-card-back">
      <h1>Kaju Katli</h1><hr>
      <p>Kaju Katli is a classic Indian sweet. It’s low sugar content makes it perfect to be eaten anytime of the day ❤️❤️</p> 
    </div>
  </div>
</div>
</div>
</div>
</t:ordertemplate>