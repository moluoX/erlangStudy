-module(geometry).
-export([area/1]).

area({rectangle, Width, Height})	-> Width * Height;
area({square, Side})				-> Side * Side;
area({circle, Radius})				-> 3.1415926 * Radius * Radius.
