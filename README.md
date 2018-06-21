## SOFTWARE ENGINEERING ACADEMY

### COMPFEST X - GO-JEK

### SECOND STAGE FINAL ASSIGNMENT

[Repository](https://github.com/gejimayu/seacompfest)

##### Assumptions
1. Map's shape is square which is N x N
2. Coordinate starts with (0,0) at the top-left of the map
3. Driver doesn't block the path between user and destination

##### Design Decision
There are 4 classes, one module, and one main program.

Classes: Driver, User, Order, Map
Module: Helper

I chose to seperate Driver and User object for two reasons. 

First reason is Driver has attribute name and User does not. 
Second reason is to improve readibility of my code and to avoid any confusion.
Third reason is for SOLID principles which specifically is Open for Extension in the future if the class grows bigger.

Map acts as real map object. User/Driver and Map is two seperate objects. 
After User/Driver has been initialized, User/Driver can be inserted into Map object through its own method.
This is done to isolate each object

Order object acts to hold order attributes.

Helper module contains functions which helps the development and avoid DRY code.

##### How to Run
1. [Install rvm and ruby](https://rvm.io/rvm/install)
2. Open terminal
3. `cd` to main directory
4. type `ruby main.rb`
