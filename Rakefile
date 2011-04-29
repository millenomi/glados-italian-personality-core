
require 'rubygems'
require 'mustache'
require 'find'

SCRIPTS = FileList['Scripts/*.mustache']
TARGET_BASE = ENV['ILABS_GLADOS_PORTAL_CONTENT_DIR'] || 'Build'
TARGET = File.join(TARGET_BASE, 'sound', 'vo', 'aperture_ai_ita')

def wav_file_for_script(src)
	x = File.basename(src, '.mustache')
	File.join(TARGET, x + '.wav')
end

WAVES = SCRIPTS.map { |x| wav_file_for_script(x) }

# ---------------------------------------

class ScriptPart < Mustache
	def initialize(path)
		self.template_file = path
	end
	
	def em(x)
		render(x).split(/\s+/).map { |x| "[[emph +]]#{x}" }.join ' '
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
	puts " == #{file}"
	puts text

	IO.popen "say -v Chiara -o \"#{aif}\"", 'w' do |io|
		io << text
	end
	
	`sox \"#{aif}\" \"#{wav}\" rate 44.1k`
	FileUtils.rm aif
end

SCRIPTS.each do |script|
	wav = wav_file_for_script(script)
	
	rule wav => [script] do |t|
		mkdir_p File.dirname(wav)
		to_wav(script, wav)
	end
end

task :default => [:build]
task :build => [TARGET]
task :build => WAVES

task TARGET do
	mkdir_p TARGET
end

task :clobber do
	WAVES.each do |w|
		rm_f w
	end
end
