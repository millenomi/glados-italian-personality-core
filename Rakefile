
require 'rubygems'
require 'mustache'
require 'find'

STEAM_USERNAME = ENV['ILABS_GLADOS_STEAM_USERNAME'] || ENV['USER']

SCRIPTS = FileList['Scripts/*.mustache']
TARGET = ENV['ILABS_GLADOS_TARGET'] || File.expand_path("~/Library/Application Support/Steam/SteamApps/#{STEAM_USERNAME}/portal/portal")
TARGET_WAVES_DIR = File.join(TARGET, 'sound', 'vo', 'aperture_ai_ita')

def wav_file_for_script(src)
	x = File.basename(src, '.mustache')
	File.join(TARGET_WAVES_DIR, x + '.wav')
end

WAVES = SCRIPTS.map { |x| wav_file_for_script(x) }

SOUNDSCRIPT = 'npc_sounds_aperture_ai.txt'
TARGET_SOUNDSCRIPT = File.join(TARGET, 'scripts', SOUNDSCRIPT)

# ---------------------------------------

class ScriptPart < Mustache
	def initialize(path)
		self.template_file = path
	end
	
	def em(x)
		render(x).split(/\s+/).map { |x| "[[emph +]]#{x}" }.join ' '
	end
	
	def here(x)
		# TODO
		br + em(x) + br
	end
	
	def br
		", "
	end
	
	def aperture_science
		"Apertùr Sàiens"
	end
	
	def enrichment_center
		"[[emph +]]Centro [[emph +]]Di [[emph +]]Arricchimento"
	end
	
	def fast(x)
		"[[rate +100]]" + render(x) + "[[rate -100]]"
	end
	
	def faster(x)
		"[[rate +200]]" + render(x) + "[[rate -200]]"
	end
	
	def pron(x)
		x
	end
end

def to_wav(file, wav)	
	aif = wav + '.aif'
	
	text = ScriptPart.new(file).render
	text = "[[rate +68]]#{text}"
	puts "\n == #{file}"
	puts text

	IO.popen "say -v Chiara -o \"#{aif}\"", 'w' do |io|
		io << text
	end
	
	`sox \"#{aif}\" \"#{wav}\" rate 44.1k`
	FileUtils.rm aif
	puts " == \n"
end

SCRIPTS.each do |script|
	wav = wav_file_for_script(script)
	
	rule wav => [script] do |t|
		mkdir_p File.dirname(wav)
		to_wav(script, wav)
	end
end

rule TARGET_SOUNDSCRIPT => [SOUNDSCRIPT] do
	mkdir_p File.dirname(TARGET_SOUNDSCRIPT)
	cp SOUNDSCRIPT, TARGET_SOUNDSCRIPT
end

rule TARGET_WAVES_DIR do
	mkdir_p TARGET_WAVES_DIR
end

task :default => [:build]

desc "Builds the .wav files into the target directory (currently #{TARGET_WAVES_DIR})"
task :build => [TARGET, TARGET_WAVES_DIR]
task :build => WAVES

desc "Same as build, and also installs the sound script (currently in #{TARGET_SOUNDSCRIPT}) enabling the .wav files in-game."
task :install => [:build, TARGET_SOUNDSCRIPT]

desc "Removes both sound files and script from the target directory"
task :clobber do
	WAVES.each do |w|
		rm_f w
	end
	
	rm_f TARGET_SOUNDSCRIPT
end

desc "Same as install, and also runs Portal."
task :run => [:install] do
	sh 'open', 'steam://run/400'
end
