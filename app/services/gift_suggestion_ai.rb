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

    if @recipient
      parts << "Recipient name: #{@recipient.name}."   if @recipient.name.present?
      parts << "Age: #{@recipient.age}."               if @recipient.age.present?
      parts << "Hobbies: #{@recipient.hobbies}."       if @recipient.hobbies.present?
      parts << "Likes: #{@recipient.likes}."           if @recipient.likes.present?
      parts << "Dislikes: #{@recipient.dislikes}."     if @recipient.dislikes.present?
      parts << "Budget: around $#{@recipient.budget}." if @recipient.budget.present?
    end

    if @event
      parts << "Event: #{@event.title}." if @event.title.present?
      parts << "Theme: #{@event.theme}." if @event.theme.present?
    end

    existing = GiftSuggestion.where(user_id: @user.id)
    existing = existing.where(recipient_id: @recipient) if @recipient
    existing = existing.where(event_id: @event.id)      if @event

    used_titles = existing.order(created_at: :asc).limit(15).pluck(:title).compact.uniq

    if used_titles.any?
      parts << "You have ALREADY suggested the following ideas for this recipient. Do NOT repeat these or close variations of them:"
      parts << used_titles.join(" ; ")
    end

    parts.join(" ")
  end

  def parse_ideas(text, count) #!!! should fully work now!!!!
    lines = text.split("\n").map{|line| line.strip.gsub(/\*+/, "").sub(/^\-\s+/, "") }.reject(&:blank?)
    Rails.logger.info "Raw AI response: #{lines.inspect}"
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

      first_line = chunk.first.to_s
      cleaned_title = first_line.sub(/^\d+\s*[\).\:\-]\s*/, "")
      cleaned_title = cleaned_title.gsub("**", "").strip
      body_lines = chunk[1..] || []
      body_text = body_lines.join(" ").strip
      full_body = body_text.dup
      price = nil
      if full_body =~ /\$([\d\.,]+)/
        price = $1.tr(",", "").to_f
      end

      sentences = full_body.split(/(?<=\.)\s+/)

      clean_sentences = sentences.reject do |s|
        s =~ /(Estimated Price|Price Estimate|Price:|\$[\d\.,]+)/i
      end

      clean_body = clean_sentences.join(" ").strip



      {
        title: cleaned_title.presence || "Gift idea",
        description: clean_body.presence || cleaned_title,
        estimated_price: price
      }
    end
  end
end
