#!/usr/bin/env ruby 

require 'find'
require 'fileutils'
require 'progressbar'

COMMAND     = ARGV.shift		# The command entered : 'list' .. etc
TARGET_DIR  = ARGV.shift 	# Directory where to find fonts
OS_FONT_DIR = "/home"
BASEDIR = "."
FONT_EXTENSIONS = %w(.abf .acfm .afm .amfm .bdf .cha .chr .comp .dfon .eot 
	.etx .f3f .ffil .fnt .fon .fot .gdr .gf .gxf .lwfn .mcf .mf .mxf .nftr .otf 
	.pcf .pfa .pfb .pfm .pfr .pk .sfd .suit .tfm .ttc .ttf .txf .vnf .woff .xfn .xft)

# ------------------------------------
# HELPER FUNCTIONS
# ------------------------------------


def is_font_file? (file_path)
	File.extname(file_path) == ".ttf"
end

def generate_progress_bar total
	# Set progress bar
	pbar = ProgressBar.new("Grabbing font", total)
	pbar.format_arguments = [:title, :percentage, :bar, :stat_for_file_transfer]
	pbar.bar_mark = "="
	pbar
end

def list_fonts_inside
	#path = File.join(dir, "**","*.")
	files = []

	find_result_enum = Find.find(BASEDIR).entries

	#pbar = generate_progress_bar(find_result_enum.count)

	find_result_enum.each do |path|
		if is_font_file?(path)
			files << path 
		end

		#pbar.set(find_result_enum.index(path))
	end
	#pbar.finish

	puts files.size.to_s + " Fonts found!"
	src = files.first
	dst = "/Users/firstdeveloper/Library/Fonts"
	
	files.each do |f| 
		FileUtils.cp f, dst, verbose: true	
		#puts f
	end
	
end

def copy_to_os_fonts_dir font_file_path
	puts "Installing font \"#{font_file_path}\" ..."
	FileUtils.cp src, dst, verbose: true
	if (File.exists?(File.join(OS_FONT_DIR, font_file)))
		puts "\"#{font_file}\" installed."
	else
		puts "\"#{font_file}\" not installed."
	end
end 


case COMMAND
when 'list' 	# Just show all fonts in <target_dir>
	list_fonts_inside 
when 'install'
	FONT = File.join(TARGET_DIR, "Fontbureau - Fonts for MAC & PC 3rd Edition GFXTRA.COM!/FontBureau [FB] 3rd Edition/World/WorldTwo.ttf")
	copy_to_os_fonts_dir FONT
end



