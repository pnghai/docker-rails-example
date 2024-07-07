begin
  require 'awesome_print'
  AwesomePrint.irb!
  require 'hirb'
  # これが無いとdisplay_widthが無くてエラー
  require 'unicode/display_width/string_ext'
  # これもrequireしないと勝手には反応しない
  require 'hirb-unicode'
rescue LoadError
  warn "could not require: #{err}"
end
if defined? AwesomePrint
  AwesomePrint.irb!
end
if defined? Hirb
  # hirbをオフにしたい時はHirb.disableする
  Hirb.enable
end
# https://gist.github.com/douglasdollars/5242393
# irb history
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File::expand_path("~/.irbhistory")

#clear and reload!
module MyIRBUtils
  def clear
    system('clear') || system('cls')
  end

  def reload!
    load $0
  end

  def clear_database
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
    end
  end
end

include MyIRBUtils
