# Explorer

<strong>Stillness in Motion</strong>

<a href="http://stillness-in-motion.herokuapp.com/">View on Heroku</a><br>
<a href="https://www.pivotaltracker.com/n/projects/1929509">Pivotaltracker</a>

<img src="https://s3-eu-west-1.amazonaws.com/stillness-in-motion/banners/banner-2.jpg">

# What is Explorer?

Explorer is my final project for <a href="https://www.wegotcoders.com">WeGotCoders</a> Web Developer Fast Track training programme. It is built with Ruby on Rails 5 and was completed in 9 days.

Explorer is a hikers/walkers social network site, where friends can get together to organise to go walking in fantastic places around the world. Its a place where you can meet people with a mutual love for the outdoors.

Users can login with Facebook OAuth or manually enter their own details. To create an Expedition, on the root page following login there is a link to create an expedition. Here you can fill out the form providing the necessary details. Make sure to put in a start and end location for Geocoder to do its magic. Once the event has been created you can invite your friends along. If you haven't got any, you can go out and make some my navigating the timeline on the root page to see other people's expeditions. Click into their profile and you can request them as a friend.

On each event once you are marked as attending or invited, you can take part in the live pub/sub MessageBoard built using ActionCable.

# Tests

This project was entirely test-driven using RSpec and Cucumber. Final test coverage: <strong>405 / 410 LOC (98.78%)</strong>
<hr>
<strong>Gems</strong>
<ul>
<li>devise</li>
<li>geocoder</li>
<li>semantic-ui</li>
<li>omniauth-facebook</li>
<li>figaro</li>
<li>action cable</li>
<li>will-paginate</li>
<li>carrierwave</li>
<li>remotipart</li>
</ul>
<br>
<strong>APIs</strong>
<ul>
<li>rails</li>
<li>amazon s3</li>
<li>facebook</li>
<li>mapbox</li>
<li>redis</li>
</ul>
