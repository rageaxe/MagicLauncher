# MagicLauncher
There are three main views in Application:
1. Define Gesture - in this view you can draw new gesture and select action for it
2. Gestures - all gestures in table view controller which can be edited
3. Input Gesture - draw gesture and after recognizing it action will run.

Recognizion algorithm was writen based on https://depts.washington.edu/aimgroup/proj/dollar/ (1$ gesture recognizer)
It have a lot of flaws, it doesnt look for concrete gesture, it will return most suited gesture, that means if you define only 1 gesture, it will always return that one gesture..
And this algorithm is extremely bad for simple gestures like lines, it works better with complex ones (shapes, stars etc).

And to recognize gesture, you should draw from same side as defined gesture, for example circle if you define circle drawing it closkwise then in input view when recognizing it you should draw it clockwise also and not anticlockwise.
