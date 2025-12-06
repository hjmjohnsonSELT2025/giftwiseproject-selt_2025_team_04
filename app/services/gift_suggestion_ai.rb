require "openai"

class GiftSuggestionAi
  def initialize(user:, event:, recipient: nil)
    @user = user
    @event = event
    @recipient = recipient
  end

  def generate(count: 3)
    client = OpenAI::Client.new

    prompt = build_prompt(count)

    response = client.chat.completions.create(
      model: "gpt-4o-mini",
      messages: [
        { role: "system", content: "You're a helpful assistant that suggests relevant thoughtful gift ideas." },
        { role: "user", content: prompt }
      ]
    )

    text = response.choices.first.message.content.to_s
    ideas = parse_ideas(text, count)

    Rails.logger.info("AI ideas parsed: #{ideas.inspect}")
    ideas
  rescue => e
    Rails.logger.error("GiftSuggestionAi error: #{e.class}: #{e.message}")
    []
  end

  private

  def build_prompt(count)
    parts = []
    parts << "Suggest #{count} specific gift ideas."
    parts << "Each idea should have a short name, a short description, and an estimate of price in USD."
    parts << "Return them as a numbered list."

    #trying best to format correctly for readability, I'm going to miss spots but that is life
    # mostly want to do it in spotslike this where it helps make sure everything there
    if @recipient
      parts << "Recipient name: #{@recipient.name}."  if @recipient.name.present?
      parts << "Age: #{@recipient.age}."              if @recipient.age.present?
      parts << "Hobbies: #{@recipient.hobbies}."      if @recipient.hobbies.present?
      parts << "Likes: #{@recipient.likes}."          if @recipient.likes.present?
      parts << "Dislikes: #{@recipient.dislikes}."    if @recipient.dislikes.present?
      parts << "Budget: about $#{@recipient.budget}." if @recipient.budget.present?
    end

    if @event
      parts << "Event: #{@event.title}." if @event.title.present?
      parts << "Theme: #{@event.theme}." if @event.theme.present?
    end

    parts.join(" ")
  end

  def parse_ideas(text, count)
    lines = text.split("\n").map(&:strip).reject(&:blank?)
    Rails.logger.info "Raw AI response: #{lines.inspect}" #trying to keep tokens down for $$ reasons, input mostly also output tho
    #numbered_lines = lines.select { |line| line =~ /^\d+\s*[\).\:\-]/ }

    #item_lines = lines.select { |line| line.match?(/^\d+\s*[\).\:\-]/) } #this should work redoing parsing completely so not one line taken for whole thing,

    #UPDATE works well but not perfect, estimated price getting left in but calling for tonight, will fix tomorrow to match pull

    # also have to redo to format new views pulled so this commit is just for progress going to have to redo a lot (tests mostly bc no longer have buttons lol)

    #item_lines.first(count).map do |line|

    #ideas = base_lines.map do |line|

      #ideas = []

      #base_lines.first(count).each do |line|
      #lines.each do |line| #testing stripping prob gonna have to tweak
      # break if ideas.size >= count

      #cleaned = line.sub(/^\s*[\).\-\:], "")
      #cleaned = line.sub(/^\s*\d+[\-\:]\s*/, "")

      #cleaned = line.sub(/^\s*\d+[\).\-\:]\s*/, "")

    chunks = []
    current_chunk = nil

    lines.each do |line|
      if line =~ /^\d+\s*[\).\:\-]\s*/
        chunks << current_chunk if current_chunk
        current_chunk = [line]
      else
        current_chunk << line if current_chunk
      end

    end
    chunks << current_chunk if current_chunk


    Rails.logger.info "Ai chunks: #{chunks.inspect}"

    #cleaned = line.sub(/^\s*\d+\s*[\).\:\-]\s*/, "")
    chunks.first(count).map do |chunk|
      next if chunk.blank?

      first_line = chunk.first
      cleaned_title = first_line.sub(/^\d+\s*[\).\:\-]\s*/, "")
      cleaned_title = cleaned_title.gsub("**", "").strip
      body_lines = chunk[1..] || []
      body_text = body_lines.join(" ").strip
      price_match = body_text.match(/\$([\d\.,]+)/)
      price =
        if price_match
          price_match[1].gsub(",", "").to_f
        else
          nil
        end

      {
        title: cleaned_title.presence || "Gift idea",
        description: body_text.presence || cleaned_title,
        estimated_price: price
      }
    end
  end
end



      #name = cleaned.split(" - ", 2)
      #name_part, rest = cleaned.split(" - ", 2)
      # name = name_part.present? ? name_part.strip : "Gift idea"

      #name = (name_part || "Gift idea").strip
      #body = (rest || "").strip
      # body ||= ""

      # price_match = body.match(/\$([\d\.,]+)/)
      #price = price_match
      #{
      #   title: name,
      #   description: (body.presence ||cleaned).strip,
      #    estimated_price: price
      # }

