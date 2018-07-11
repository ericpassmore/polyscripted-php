# polyscripted-php

Polyscripting is a cybesecurity security technique used to stop code injection attacks. It is based on Moving Target Defense approaches (see http://web.mit.edu/br26972/www/pubs/mt_survey.pdf ) which work by increasing the costs for adversaries to successfully attack a system.

Before Polyscripting, any script injection bug (e.g. an unguarded 'eval') would be exploitable across all instances of the script--in teh case of PHP, literally billionso of computers. In effect, current systems are "break once, run everywhere". By creating unique PHP languages on the fly for every PHP instance, it becomes extremely difficult for attackers build attacks that can work across every machine--"break once, run once". 

# overview

https://blog.polyverse.io/introducing-polyscripting-the-beginning-of-the-end-of-code-injection-fe0c99d6f199

# tutorial

https://github.com/polyverse/polyscripted-php/blob/master/Ps-PlaygroundReadMe.md

