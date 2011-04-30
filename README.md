This repository contains tools that allow you to produce Italian .WAV files to replace GLaDOS's voice in the Valve game [Portal](http://store.steampowered.com/app/400/). Each file corresponds to a Mustache template in the Scripts directory; you can produce the files by running the included Rakefile with [Rake](http://rake.rubyforge.org/).

To produce successfully, you must:

* Be on a Mac.

* Have the "Chiara" voice that's part of the [Infovox iVox voice pack](http://www.assistiveware.com/infovox_ivox.php). Which is the only Italian voice I found that can plug into Apple's text-to-speech engine (10.6-), and darn it, it prohibits redistribution. But you can grab it and render the files for yourself, wink wink. Just don't redistribute them.

* Install the [Mustache](http://mustache.github.com/) and [Rake](http://rake.rubyforge.org/) gems:

		$ gem install mustache rake

* Have the [SoX audio editing command-line utility](http://sox.sourceforge.net/) on the PATH.

* Quit Portal if it's running. (Make sure you have Steam installed, Portal installed through Steam, and that you have run it at least once.)

* Run:
		
		$ export ILABS_GLADOS_STEAM_USERNAME="your_username_on_steam_123"
		$ # if it's the same as your Mac account short name, you can skip the above line :)
		$ rake run
		
… and enjoy! If you want to check up how stuff works rather than installing it in your Portal content dir, create a sandbox folder for the Rakefile to play in and export its full path to the ILABS_GLADOS_TARGET environment variable, and also look at the other targets with `rake -T`.