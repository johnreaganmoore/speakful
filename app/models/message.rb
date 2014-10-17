class Message < ActiveRecord::Base

	before_create :make_voice_link
	after_create :send_text_message

	belongs_to :user

	def make_voice_link
		#define url prefix
		prefix = "http://tts-api.com/tts.mp3?q="
		# Append url segment to url prefix
		self.voice_link = prefix + create_url_segment(self.text)
	end

	def create_url_segment(text)
		#Swap spaces from text string for pluses
		text.gsub(" ","+")
	end

	def send_text_message
    number_to_send_to = "+16158290839"
 
    twilio_sid = ENV["twilio_sid"]
    twilio_token = ENV["twilio_token"]
    twilio_phone_number = ENV["twilio_phone_number"]
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.messages.create(
      :from => twilio_phone_number,
      :to => number_to_send_to,
      :body => "Message from John Reagan:",
      :media_url => "#{self.make_voice_link}"
    )
  end

end
