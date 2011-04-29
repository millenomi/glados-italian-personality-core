This repository contains tools that allow you to produce Italian .WAV files to replace GLaDOS's voice in the Valve game [Portal](http://store.steampowered.com/app/400/). Each file corresponds to a Mustache template in the Scripts directory; you can produce the files by running the included Rakefile with [Rake](http://rake.rubyforge.org/).

To produce successfully, you must:

* Be on a Mac.

* Have the "Chiara" voice that's part of the [Infovox iVox voice pack](http://www.assistiveware.com/infovox_ivox.php). Which is the only Italian voice I found that can plug into Apple's text-to-speech engine (10.6-), and darn it, it prohibits redistribution. But you can grab it and render the files for yourself, wink wink. Just don't redistribute them.

* Install the [Mustache](http://mustache.github.com/) and [Rake](http://rake.rubyforge.org/) gems:

		$ gem install mustache rake

* Have the [SoX audio editing command-line utility](http://sox.sourceforge.net/) on the PATH.

* Run:

		$ rake
		
* The files are put in `./Build` by default. You can change where they go using the `ILABS_GLADOS_PORTAL_CONTENT_DIR` environment variable.

To install the produced .WAV files:

* Install and run Portal at least once.

* In your `SteamApps\USERNAME\portal\portal` directory, put the `npc_sounds_aperture_ai.txt` file in this folder in a new `scripts` folder, and the .WAV files in a `sound\vo\aperture_ai_ita` folder.

* Restart Portal and play! :D
