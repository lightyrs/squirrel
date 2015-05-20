content_types = %w(text image video audio multimedia)

text_classifications = [
  'news',
  'human interest',
  'leak',
  'gossip',
  'trend report',
  'long-form journalism',
  'interview',
  'speech',
  'list',
  'listicle',
  'review',
  'tutorial',
  'comparison',
  'case study',
  'rant',
  'true story',
  'short story',
  'prediction',
  'press release',
  'analysis',
  'live blog',
  'q&a',
  'contest',
  'audio transcript',
  'video transcript',
  'summary',
  'advice',
  'guide',
  'round up',
  'op-ed',
  'comment',
  'historical',
  'status update',
  'code',
  'code repository',
  'technical',
  'technical explanation',
  'e-book',
  'advertisement',
  'petition',
  'satire'
]

image_classifications = [
  'infographic',
  'slideshow',
  'news',
  'advertisement',
  'animated gif',
  'comic',
  'photograph',
  'meme'
]

video_classifications = [
  'webisode',
  'vlog',
  'music video',
  'concert',
  'movie trailer',
  'tv show',
  'movie',
  'commercial',
  'news',
  'historical',
  'podcast',
  'interview',
  'speech',
  'tutorial',
  'review',
  'press release',
  'live stream',
  'advertisement'
]

audio_classifications = [
  'song',
  'album',
  'soundtrack',
  'concert',
  'speech',
  'live stream',
  'interview',
  'news',
  'historical',
  'podcast',
  'talk radio',
  'advertisement'
]

multimedia_classifications = [
  'presentation',
  'game',
  'advertisement'
]

classifications = {
  text:       text_classifications,
  image:      image_classifications,
  video:      video_classifications,
  audio:      audio_classifications,
  multimedia: multimedia_classifications
}

content_types.each do |content_type|
  puts "Creating ContentType: #{content_type}".green
  ContentType.find_or_create_by(name: content_type)
end

classifications.each do |key, val|
  val.each do |name|
    puts "Creating Classification: [#{key}] #{name}".yellow
    Classification.create(
      name: name,
      content_type_id: ContentType.find_by(name: key).id
    )
  end
end
