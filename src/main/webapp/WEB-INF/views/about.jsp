<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:wrapper>
<style>
* {
  box-sizing: border-box;
}

/* Add a gray background color with some padding */
body {
  font-family: Cursive;
  padding: 20px;
  background: #f1f1f1;
}

/* Header/Blog Title */
.header {
  padding: 30px;
  font-size: 40px;
  text-align: center;
  background: white;
}

/* Create two unequal columns that floats next to each other */
/* Left column */
.leftcolumn {   
  float: left;
  width: 75%;
}

/* Right column */
.rightcolumn {
  float: left;
  width: 25%;
  padding-left: 20px;
}

/* Fake image */
.fakeimg {
  background-color: #aaa;
  width: 100%;
  padding: 20px;
}

/* Add a card effect for articles */
.card {
   background-color: white;
   padding: 20px;
   margin-top: 20px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Footer */
.footer {
  padding: 20px;
  text-align: center;
  background: #ddd;
  margin-top: 20px;
}

/* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 800px) {
  .leftcolumn, .rightcolumn {   
    width: 100%;
    padding: 0;
  }
}
</style>
<div class="header">
  <h2>About us</h2>
</div>

<div class="row">
  <div class="leftcolumn">
    <div class="card">
      <h2>Madhuram Sweets and Cafe</h2><br>
      <div>
		<img src="<c:url value="/images/madhuram_shop_pic.jpg" />" width="800">
		</div><br>
      <p>India is a land of food and foodies. 
It won’t be wrong to say about Indians that they live to eat, and eat to enjoy! From the tiny ‘galis’ of Bokaro to the Mafhuram Sweets and Cafe in Sector 4 of Bokaro, 
all food destinations serve as the ultimate paradise for Indians. 
The variety of cuisines that one could find in India and the taste that one could savour, is very difficult to find anywhere else in the world. 
Indians and sweets have a particular affinity with each other.
<br>
Opened in 2000 as a small cafe, 
Madhuram Sweets and cafe has grown to three locations and added a full menu. 
Madhuram Sweets and cafe is way more than just a small-town cafe – 
it is the place to go from everything to a cup of coffee on the run, 
to specialty coffee drinks to sip and savor as well as a desert menu -
not to mention the amazing pastries, cookies and muffins.  
Yet, it still offers that small town feel and continues to make amazing coffee for special celebrations and elaborate wedding sweets, 
custom made for each bride.  This cafe has a lot to offer.</p>
    </div>
  </div>
  <div class="rightcolumn">
    <div class="card">
      <h2>Contact us</h2>
      <a href="mailto:madhuram@gmail.com">📧 Email Us</a>
      <a href="tel:+917209991112">📞 Call us</a>
    </div>
    <div class="card">
      <h3>Our specialities</h3>
      <div><img src="<c:url value="/images/madhuram_fam_pic.jpg" />" width="250"></div><br>
      <div><img src="<c:url value="/images/madhuram_fam_pic1.jpg" />" width="250" height="250"></div><br>
    </div>
  </div>
</div>

<div class="footer">
  <h2>Thanks for shopping with us 🙏🙏<br>We hope you will visit again soon!!</h2>
</div>
</t:wrapper>