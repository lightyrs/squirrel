content_types = %w(text html image video audio multimedia)

text_classifications = [
  'News',
  'Human Interest',
  'Leak',
  'Gossip',
  'Trend Report',
  'Long-form Journalism',
  'Interview',
  'Speech',
  'List',
  'Listicle',
  'Review',
  'Tutorial',
  'Comparison',
  'Case Study',
  'Rant',
  'True Story',
  'Short Story',
  'Prediction',
  'Press Release',
  'Analysis',
  'Live Blog',
  'Q&A',
  'Contest',
  'Audio Transcript',
  'Video Transcript',
  'Summary',
  'Advice',
  'Guide',
  'Round Up',
  'Op-Ed',
  'Comment',
  'Historical',
  'Status Update',
  'Code',
  'Code Repository',
  'Technical',
  'Technical Explanation',
  'E-book',
  'Advertisement',
  'Petition',
  'Satire'
]

image_classifications = [
  'Infographic',
  'Slideshow',
  'News',
  'Advertisement',
  'Animated Gif',
  'Comic',
  'Photograph',
  'Meme'
]

video_classifications = [
  'Webisode',
  'Vlog',
  'Music Video',
  'Concert',
  'Movie Trailer',
  'TV Show',
  'Movie',
  'Commercial',
  'News',
  'Historical',
  'Podcast',
  'Interview',
  'Speech',
  'Tutorial',
  'Review',
  'Press Release',
  'Live Stream',
  'Advertisement'
]

audio_classifications = [
  'Song',
  'Album',
  'Soundtrack',
  'Concert',
  'Speech',
  'Live Stream',
  'Interview',
  'News',
  'Historical',
  'Podcast',
  'Talk Radio',
  'Advertisement'
]

multimedia_classifications = [
  'Presentation',
  'Game',
  'Advertisement'
]

html_classifications = [text_classifications + image_classifications + video_classifications + audio_classifications + multimedia_classifications].flatten

classifications = {
  text:       text_classifications,
  html:       html_classifications,
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
