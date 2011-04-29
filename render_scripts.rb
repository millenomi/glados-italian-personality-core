#!/usr/bin/env ruby

require 'rubygems'
require 'mustache'
require 'find'
require 'fileutils'

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
		"Epierciur Sàiens"
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

here = ENV['ILABS_GLADOS_OUTPUT_DIR'] || File.dirname(__FILE__)
where = File.join(File.dirname(__FILE__), 'Scripts')
Find.find where do |file|
	next unless file =~ /\.mustache$/
	
	wav = File.join here, File.basename(file, '.mustache') + '.wav'
	aif = File.join here, File.basename(file, '.mustache') + '.aif'
	
	text = ScriptPart.new(file).render
	text = "[[rate +65]]#{text}"
	puts " == #{file}"
	puts text

	IO.popen "say -v Chiara -o \"#{aif}\"", 'w' do |io|
		io << text
	end
	
	`sox \"#{aif}\" \"#{wav}\" rate 44.1k`
	FileUtils.rm aif
end
