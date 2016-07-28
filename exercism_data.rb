require 'httparty'
track_names = ["assembly", "bash", "c", "clojure", "coffeescript", "cpp", "csharp", "dlang", "ecmascript", "elixir", "erlang", "fsharp", "go", "groovy", "haskell", "java", "javascript", "lisp", "lua", "nimrod", "objective-c", "ocaml", "perl5", "perl6", "php", "plsql", "powershell", "proofs", "python", "r", "ruby", "rust", "scala", "sml", "swift", "vbnet"]
track_names_without_data = ["assembly", "nimrod", "proofs"]
track_names.each do |track|
    response = HTTParty.get("http://exercism.io/api/v1/stats/#{track}/activity/recent")
    if response.code == 200
        json = JSON.parse(response.body)
        iteration_count = json["track"]["problems"].map {|problem| problem[1]["iterations"]}.reduce(:+)
        print "#{iteration_count} iterations submitted for #{response["track"]["id"]} in the last 30 days"
    else 
        print "500 for track #{track}"
    end
end
# 28JUL16
# 500 for track assembly
# 15 iterations submitted for bash in the last 30 days
# 22 iterations submitted for c in the last 30 days
# 616 iterations submitted for clojure in the last 30 days
# 18 iterations submitted for coffeescript in the last 30 days
# 279 iterations submitted for cpp in the last 30 days
# 281 iterations submitted for csharp in the last 30 days
# iterations submitted for dlang in the last 30 days
# 204 iterations submitted for ecmascript in the last 30 days
# 2526 iterations submitted for elixir in the last 30 days
# 177 iterations submitted for erlang in the last 30 days
# 205 iterations submitted for fsharp in the last 30 days
# 1589 iterations submitted for go in the last 30 days
# 15 iterations submitted for groovy in the last 30 days
# 732 iterations submitted for haskell in the last 30 days
# 729 iterations submitted for java in the last 30 days
# 1869 iterations submitted for javascript in the last 30 days
# 106 iterations submitted for lisp in the last 30 days
# 83 iterations submitted for lua in the last 30 days
# 500 for track nimrod19 
# iterations submitted for objective-c in the last 30 days
# 78 iterations submitted for ocaml in the last 30 days
# 23 iterations submitted for perl5 in the last 30 days
# 0 iterations submitted for perl6 in the last 30 days
# 171 iterations submitted for php in the last 30 days
# 0 iterations submitted for plsql in the last 30 days
# iterations submitted for powershell in the last 30 days
# 500 for track proofs
# 1762 iterations submitted for python in the last 30 days
# 1 iterations submitted for r in the last 30 days
# 3098 iterations submitted for ruby in the last 30 days
# 1378 iterations submitted for rust in the last 30 days
# 610 iterations submitted for scala in the last 30 days
# 0 iterations submitted for sml in the last 30 days
# 293 iterations submitted for swift in the last 30 days
# 0 iterations submitted for vbnet in the last 30 days

# com/search/issues?q=label:\"#{input_string}\"+language:ruby+st
# get track names from JSON

# file = File.read('exercism_tracks.json')
# json = JSON.parse(file)
# json["tracks"].first["slug"]
# names = json["tracks"].map {|track| track["slug"]}