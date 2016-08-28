require 'httparty' 


class ExercismData
  #need to delete nil values at some step

  TRACK_NAMES = ["bash", "c", "clojure", "coffeescript", "cpp", "csharp", "dlang", "ecmascript", "elixir", "erlang", "fsharp", "go", "groovy", "haskell", "java", "javascript", "lisp", "lua", "objective-c", "ocaml", "perl5", "perl6", "php", "plsql", "powershell", "python", "r", "ruby", "rust", "scala", "sml", "swift", "vbnet"]
  attr_reader :whole_hash

  def initialize
    @whole_hash = {}
  end

  def get_tracks
    TRACK_NAMES.each do |track|
      single_track = get_track_stats(track)
      add_to_hash(single_track)
    end
  end

  def save_to_file(file_name)
    # name with todays date
    out_file = File.new(file_name, "w")
    out_file.puts(@whole_hash)
    out_file.close
  end

  def iteration_counts
    #fix this
    #will likely have to get rid of nils before this step

    @counts_of_iterations = @whole_hash.map do |track|
      if track[1]["problems"] #temporary hack
        track_counts = track[1]["problems"].map do |problem|
          problem[1]["iterations"]
        end
      end
    { track[0] => track_counts.reduce(:+) }
    end
    @counts_of_iterations
  end

  def read_from_file(file_name)
    contents = File.read(file_name)
    @whole_hash = eval(contents)
  end

  def save_to_csv(file_name)
    column_names = @counts_of_iterations.map {|f| f.keys[0]}
    vals = @counts_of_iterations.map {|f| f.values[0]}
    s=CSV.generate do |csv|
      csv << column_names
      csv << vals
    end
    File.write(file_name, s)
  end




  private

    def get_track_stats(track)
      response = HTTParty.get("http://exercism.io/api/v1/stats/#{track}/activity/recent")
      if response.code == 200
        json = JSON.parse(response.body)
        json["track"]
      else
        puts "track #{track} not found"
        {track["id"] => "not found"}
        # change this so i don't have nil values
      end
    end

    def add_to_hash(single_track)
      track_name = single_track["id"]
      @whole_hash[track_name] = single_track
    end

end
# a.delete_if {|f| f.values[0] == nil}
# a.sort_by {|f| f.values[0]}

  def save_to_csv(file_name, array)
    column_names = array.map {|f| f.keys[0]}
    vals = array.map {|f| f.values[0]}
    s=CSV.generate do |csv|
      csv << column_names
      csv << vals
    end
    File.write(file_name, s)
  end
