<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="collectibles" tilewidth="16" tileheight="16" tilecount="16" columns="4">
 <image source="../graphics/spritesheets/power-up.png" width="64" height="64"/>
 <tile id="0" type="collectible">
  <properties>
   <property name="frames" value="1-2"/>
   <property name="params" value="spread"/>
   <property name="points" type="int" value="500"/>
   <property name="row" type="int" value="1"/>
   <property name="type" value="weapon"/>
  </properties>
 </tile>
 <tile id="8" type="collectible">
  <properties>
   <property name="charge amount" type="int" value="1"/>
   <property name="frames" value="1-2"/>
   <property name="params" value="super"/>
   <property name="row" type="int" value="3"/>
   <property name="type" value="weapon"/>
  </properties>
 </tile>
 <tile id="12" type="collectible">
  <properties>
   <property name="duration" type="int" value="5"/>
   <property name="frames" value="1-2"/>
   <property name="points" type="int" value="200"/>
   <property name="row" type="int" value="4"/>
   <property name="type" value="shield"/>
  </properties>
 </tile>
 <tile id="14" type="collectible">
  <properties>
   <property name="frames" value="3-4"/>
   <property name="params" value="plasma"/>
   <property name="points" type="int" value="500"/>
   <property name="row" type="int" value="4"/>
   <property name="type" value="weapon"/>
  </properties>
 </tile>
</tileset>
