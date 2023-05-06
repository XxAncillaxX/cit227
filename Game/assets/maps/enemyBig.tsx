<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="enemyBig" tilewidth="32" tileheight="32" tilecount="2" columns="2">
 <image source="../graphics/spritesheets/enemy-big.png" width="64" height="32"/>
 <tile id="0" type="enemy">
  <properties>
   <property name="frameRow" type="int" value="1"/>
   <property name="frames" value="1-2"/>
   <property name="health" type="int" value="6"/>
   <property name="image" value="enemy-big.png"/>
   <property name="weapon" type="int" propertytype="weapon" value="3"/>
  </properties>
 </tile>
 <tile id="1" type="enemy">
  <properties>
   <property name="frameRow" type="int" value="1"/>
   <property name="frames" value="1-2"/>
   <property name="health" type="int" value="6"/>
   <property name="image" value="enemy-big.png"/>
   <property name="weapon" type="int" propertytype="weapon" value="3"/>
  </properties>
 </tile>
</tileset>
