<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="enemyMedium" tilewidth="32" tileheight="16" tilecount="2" columns="2">
 <image source="../graphics/spritesheets/enemy-medium.png" width="64" height="16"/>
 <tile id="0" type="enemy">
  <properties>
   <property name="frameRow" type="int" value="1"/>
   <property name="frames" value="1-2"/>
   <property name="health" type="int" value="3"/>
   <property name="image" value="enemy-medium.png"/>
   <property name="weapon" type="int" propertytype="weapon" value="1"/>
  </properties>
 </tile>
 <tile id="1" type="enemy">
  <properties>
   <property name="frameRow" type="int" value="1"/>
   <property name="frames" value="1-2"/>
   <property name="health" type="int" value="3"/>
   <property name="image" value="enemy-medium.png"/>
   <property name="weapon" type="int" propertytype="weapon" value="1"/>
  </properties>
 </tile>
</tileset>
